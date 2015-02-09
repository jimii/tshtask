require 'open-uri'
require 'net/http'

class Exchange < ActiveRecord::Base

  # constants
  DATA_PREFIX = 'http://www.nbp.pl/kursy/xml/'
  DATA_DIR = 'dir.txt'
  DATA_LATEST = 'LastC.xml'

  # relations
  has_many :currencies, -> { order(:name) }, dependent: :destroy

  # validation
  validates :name, presence: true, uniqueness: true

  # Open file from nbp.pl
  #
  # * Use Nokogiri to open xml file and return data

  def self.get_nbp_xml(file)
      Nokogiri::XML(open(self::DATA_PREFIX+file))
  end

  # Save rates
  #
  # * get data
  # * get/create exchange
  # * update/add currencies

  def self.save_rates(file, info = false)

    data = self::get_nbp_xml(file)

    data_created_at = data.xpath('//tabela_kursow//data_notowania').first.content
    data_name = data.xpath('//tabela_kursow//numer_tabeli').first.content

    begin
      exchange = Exchange.find_or_create_by(name: data_name, created_at: data_created_at)
      exchange.currencies.destroy_all

      data.xpath('//pozycja').each do |item|
        Currency::parse_currency(item, exchange)
      end

      exchange.send_info if info===true
    end


  end

  # Populate table with archive data
  #
  # * get data
  # * parse each line
  # * if 'c' type found save it

  def self.populate

    #self.save_rates(self::DATA_LATEST, true)
    uri = URI(self::DATA_PREFIX+self::DATA_DIR)
    dir = Net::HTTP.get(uri)

    dir.each_line do |line|
      file_line = line.delete!("\r\n") + '.xml'
      self.save_rates(file_line, false) if line[0] == 'c'
    end

  end

  # Send info

  def send_info

    @exchange = Exchange.order(created_at: :desc).limit(1)
    User.all.each do |user|
      UserMailer.send_info(user.email, @exchange).deliver
    end

  end

end
