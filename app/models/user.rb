class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Relationship
  has_many :user_stocks
  has_many :stocks, through: :user_stocks

  # User can add a stock only if he did not overreach the limit and if stock has not been added yet
  def can_add_stock?(ticker_symbol)
    under_stock_limit? && !stock_already_added?(ticker_symbol)
  end

  def under_stock_limit?
    (user_stocks.count < 10)
  end

  def stock_already_added?(ticker_symbol)
    stock = Stock.find_by_ticker ticker_symbol
    return false unless stock # Stock was not found is database
    user_stocks.where(stock_id: stock.id).exists?
  end

  def full_name
    return "#{first_name} #{last_name}".strip if (first_name || last_name)
    'Anonymous'
  end

end
