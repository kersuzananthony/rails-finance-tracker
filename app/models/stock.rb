class Stock < ActiveRecord::Base

  # Relationship
  has_many :user_stocks
  has_many :users, through: :user_stocks

  def self.new_from_lookup(ticker_symbol)
    # Use stock_quote gem to get stock info
    look_up_stock = StockQuote::Stock.quote(ticker_symbol)
    return nil unless look_up_stock.name

    new_stock = new(ticker: look_up_stock.symbol, name: look_up_stock.name)
    new_stock.last_price = new_stock.price
    # Return a new instance of Stock
    new_stock
  end

  # Scope method for query by ticker value
  def self.find_by_ticker(ticker_symbol)
    where(ticker: ticker_symbol).first
  end

  # Get stock price
  def price
    closing_price = StockQuote::Stock.quote(ticker).close
    return "#{closing_price} (Closing)" if closing_price # if not nil, we return closing price

    opening_price = StockQuote::Stock.quote(ticker).open
    return "#{opening_price} (Opening)" if opening_price

    'Unavailable'
  end

end
