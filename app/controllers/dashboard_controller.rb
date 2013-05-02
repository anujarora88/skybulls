class DashboardController < Users::AbstractController



  def index
    @registered_leagues = current_user.leagues.where(completed: false).order("end_time")

  end
end
