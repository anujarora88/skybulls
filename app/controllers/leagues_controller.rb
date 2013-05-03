class LeaguesController < Users::AbstractController

  def index
    @exchanges = Exchange.all
    leagues = League.where("end_time >= :end_time", {end_time: Time.now})
    if params[:type] == "virtual"
      leagues = leagues.where("buy_in = 0")
    else
      leagues = leagues.where("buy_in > 0")
    end
    @leagues = leagues.order("end_time").all - current_user.leagues
  end

  def show
  end

  def subscribe
  end

  def unsubscribe
  end
end
