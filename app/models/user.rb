class User < ApplicationRecord
  MAX_STOCKS_PER_USER = 10

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_and_belongs_to_many :stocks

  def stock_already_added?(ticker_sym)
    stock = Stock.by_ticker(ticker_sym).first
    return false unless stock
    stocks.where(id: stock.id).exists?
  end

  def under_stock_limit?
    stocks.count < MAX_STOCKS_PER_USER
  end

  def can_add_stock?(ticker_sym)
    under_stock_limit? && !stock_already_added?(ticker_sym)
  end
end
