class MoneyController < ApplicationController

  before_filter :authenticate_user!

  # latest / index
  def index
    @exchange = Exchange.order(created_at: :desc).page(params[:page]).per(1)
  end

  # Refresh rates
  #
  # refresh and send info

  def refresh_rates
    Exchange.save_rates(Exchange::DATA_LATEST, true)
    redirect_to money_index_path
  end

  # Report
  #
  # count and display chart

  def report
    @symbol = params[:id]
    @currencies = Currency.where(code: @symbol).order(exchange_id: :asc)

    @buy_average = @currencies.average(:buy_price).round(4)
    @sell_average = @currencies.average(:sell_price).round(4)

    @buy_min = @currencies.minimum(:buy_price).round(4)
    @buy_max = @currencies.maximum(:buy_price).round(4)

    @sell_min = @currencies.minimum(:sell_price).round(4)
    @sell_max = @currencies.maximum(:sell_price).round(4)

    @buy_median = @currencies.median(:buy_price).round(4)
    @sell_median = @currencies.median(:sell_price).round(4)

    @chart = Currency.chart(@currencies)
  end


end
