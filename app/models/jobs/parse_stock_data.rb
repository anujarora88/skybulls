module Jobs
  class ParseStockData < Struct.new(:input)
    include ErrorTracking

    def perform
      data = JSON.parse(input)
      data.each do |symbol, array|
         exchange_symbol, stock_symbol = symbol.split(":")
         exchange = Exchange.find_by_symbol(exchange_symbol)
        if exchange
          stock = exchange.stocks.where(symbol: stock_symbol).first
          if stock
            array.each do |latest_info|
              date = Time.at(latest_info["date"])
              bids = stock.bids.where("created_at <= :date AND trade_id IS NULL AND ((type = '#{Bids::Buy.name}' AND price_cents >= :price_cents) OR
                                (type = '#{Bids::Sell.name}' AND price_cents <= :price_cents) )", {date: date, price_cents: latest_info["price"] * 100}).all
              bids.each do |b|
                if b.user_league_association.league.trade_allowed?(date)
                  b.execute_trade!(Money.new(latest_info["price"] * 100, stock.latest_price_currency))
                end
              end
            end
            latest_info = array.last
            stock.latest_price = Money.new(latest_info["price"] * 100, stock.latest_price_currency)
            stock.change = latest_info['change']
            stock.percentage_change = latest_info['percentageChange']
            stock.save!
          end
        end
      end
    end



  end
end