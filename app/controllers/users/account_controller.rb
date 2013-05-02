class Users::AccountController < Users::AbstractController

  def summary
    @registered_leagues = current_user.leagues.order("end_time DESC")
  end

  def statement
    @completed_leagues = current_user.user_league_associations.joins(:league).where("leagues.completed" => false).order("end_time DESC")

  end

end
