class UserStocksController < ApplicationController
  def create
    stock = Stock.by_ticker(params[:stock_ticker]).first

    redirect_to my_portfolio_path, alert: 'You already has this stock.' if current_user.stocks.include?(stock)
    
    if stock.blank?
      stock = Stock.new_from_lookup(params[:stock_ticker])
      stock.save
    end
    current_user.stocks << stock
    redirect_to my_portfolio_path, notice: "#{stock.name} was successfully added to yours stocks."
  end

  def destroy
    stock = Stock.find(params[:id])
    current_user.stocks.delete(stock)
    redirect_to my_portfolio_path, notice: 'Stock was successfully deleted.'
  end
end
