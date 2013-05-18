class LeagueRegistrationObserver < ActiveRecord::Observer
  observe :user_league_association

  def after_create(user_league_association)
    user = User.find(user_league_association.user_id)
    league = League.find(user_league_association.league_id)
    league.notify(user,"You have successfully registered for the #{league.title} league")
    if league.start_time>Time.now
      UserMailer.register_email(user,league).deliver
    end

  end
end
