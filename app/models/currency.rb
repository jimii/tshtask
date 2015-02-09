class Currency < ActiveRecord::Base

  belongs_to :exchange, -> { order(created_at: :desc) }

  validates_presence_of :name, :converter, :code, :buy_price, :sell_price, :exchange
  validates_numericality_of :converter, :buy_price, :sell_price


  # Parse object from xml element
  #
  # * define attributes
  # * try to create object

  def self.parse_currency(item, exchange)

    attributes = {
        name: 'nazwa_waluty',
        converter: 'przelicznik',
        code: 'kod_waluty',
        buy_price: 'kurs_kupna',
        sell_price: 'kurs_sprzedazy'
    }

    begin
      currency = Currency.new
      attributes.each do |key, value|
          currency[key] = item.xpath(value).first.content.gsub(',','.')
      end
      currency.exchange = exchange
      currency.save
    rescue Exception => e
      # old format (name: 'nazwa_kraju')
    end

  end

  # Chart
  #
  # just 200 records for demo

  def self.chart(currencies)

    dates = Array.new
    values_sell = Array.new
    values_buy = Array.new

    currencies.last(200).each do |currency|
      dates.push(currency.exchange.created_at.strftime("%Y %m. %d"))
      values_buy.push(currency.buy_price)
      values_sell.push(currency.sell_price)
    end

    @chart = LazyHighCharts::HighChart.new('basic_line') do |f|
      f.chart({ type: 'line',
                marginRight: 130,
                marginBottom: 25 })

      f.xAxis({
                  categories: dates
              })
      f.yAxis({
                  title: {
                      text: 'Value'
                  },
                  plotLines: [{
                                  value: 0,
                                  width: 1,
                                  color: '#808080'
                              }]
              })
      f.tooltip({
                    valueSuffix: 'zł'
                })
      f.legend({
                   layout: 'vertical',
                   align: 'right',
                   verticalAlign: 'top',
                   x: -10,
                   y: 100,
                   borderWidth: 0
               })
      f.series({
                   name: 'Sell price',
                   data: values_sell
               })
      f.series(
          name: 'Buy price',
          data: values_buy
      )

    end

    @chart

  end

end
