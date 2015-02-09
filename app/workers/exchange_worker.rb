class ExchangeWorker
  include Sidekiq::Worker

  def perform
    Exchange.save_rates(Exchange::DATA_LATEST, true)
  end

end