class Leagues::OpenTradesController < Leagues::AbstractController

  append_before_filter :initialize_open_trades

  def index

  end

  private

    def initialize_open_trades
      @open_trades = @user_league_association.open_trades
    end

end
