class StocksController < ApplicationController
  def search
    if params[:stock].present?
      @stock = Stock.new_from_lookup(params[:stock])
      flash.now[:alert] = 'You have entered an incorrect symbol.' unless @stock
    else
        flash.now[:alert] = 'You have entered an empty search string.'
    end
    respond_to do |format|
      format.js { render partial: 'users/result' }
    end 
  end
end
