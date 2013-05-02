class LeaguesController < Users::AbstractController

  def index
    @exchanges = Exchange.all
    @leagues = League.where("end_time >= :end_time", {end_time: Time.now}).order("end_time").all - current_user.leagues
  end

  def show
  end

  def subscribe
  end

  def unsubscribe
  end
end
