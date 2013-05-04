class Leagues::PendingTradesController < Leagues::AbstractController

  append_before_filter :initialize_pending_trades

  def index

  end

  def destroy
    @pending_trade = @user_league_association.bids.find(params[:id])
    if @pending_trade.completed?
      @error_message = "This trade has already been executed!"
      render :json => {status: "error", message: @error_message}
    else
       @pending_trade.destroy
       render :json => {status: "success"}
    end
  end

  private

  def initialize_pending_trades
    @pending_trades = @user_league_association.pending_trades
  end
end
