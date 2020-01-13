class Stock < ApplicationRecord 
  scope :find_by_ticker, -> (ticker_symbol) { where(ticker: ticker_symbol) }
 
  def self.new_from_lookup(ticker_symbol)
    begin
      client = IEX::Api::Client.new(publishable_token: 'sk_928f6103385e4fc1a2f4cdb3afd325c9')
      looked_up_stock = client.quote(ticker_symbol)
      new(  #This new is the same that Stock.new() because this is a class method
        name: looked_up_stock.company_name,
        ticker: looked_up_stock.symbol,
        last_price: looked_up_stock.latest_price
      )
    rescue Exception => e
      return nil
    end
  end
end
