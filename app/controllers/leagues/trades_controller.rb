class Leagues::TradesController < Leagues::AbstractController

  layout "popup"

  prepend_before_filter :initialize_variables

  def buy
    if request.post?
      if params[:trade_type] == "latest"
        @trade = Trades::Buy.new({stock: @stock, user_league_association: @user_league_association}.merge(params[:trade]))
        @trade.price = @stock.latest_price
        if @user_league_association.balance < Money.new(@trade.price_cents * @trade.amount, @trade.price_currency)
          @error_message = "Not enough balance!"
          render 'buy'
          return
        elsif !@user_league_association.league.in_progress?
          @error_message = "No trades are allowed at this time!"
          render 'buy'
          return
        else
          @trade.save!
        end
      elsif params[:trade_type] == "custom"
        @trade = Bids::Buy.new({stock: @stock, user_league_association: @user_league_association}.merge(params[:trade]))
        @trade.save!
      end
      render 'success'
    end
  end

  def sell
    @stock_amount = @user_league_association.stock_amount(@stock)
    if request.post?
      if params[:trade_type] == "latest"
        @trade = Trades::Sell.new({stock: @stock, user_league_association: @user_league_association}.merge(params[:trade]))
        @trade.price = @stock.latest_price
        if @stock_amount < @trade.amount
           @error_message = "Can not sell more than #{@stock_amount} shares!"
          render 'sell'
          return
        elsif !@user_league_association.league.in_progress?
          @error_message = "No trades are allowed at this time!"
          render 'buy'
          return
        else
          @trade.save!
          render 'success'
        end
      elsif params[:trade_type] == "custom"
        @trade = Bids::Sell.new({stock: @stock, user_league_association: @user_league_association}.merge(params[:trade]))
        if @stock_amount < @trade.amount
          @error_message = "Can not sell more than #{@stock_amount} shares!"
          render 'sell'
        else
          @trade.save!
          render 'success'
        end
      end

    end
    if @stock_amount == 0
      render "no_shares"
    end

  end

  def initialize_variables
    @stock = Stock.find(params[:id])
    @trade = Trade.new()
  end

end
