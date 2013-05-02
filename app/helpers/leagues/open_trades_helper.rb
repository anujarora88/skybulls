module Leagues::OpenTradesHelper

  def dollar_return(avg_price, current_price, amount)
      humanized_money_with_symbol((current_price - avg_price) * amount)
  end

  def percentage_return(avg_price, current_price, amount)
     number_to_percentage((current_price/avg_price - 1)*100, precision: 2)
  end

  def current_price_span_class(avg_price, current_price)
     avg_price > current_price ? 'down-arrow-red' : 'up-arrow'
  end

end
