class UserMailer < ActionMailer::Base
  default from: "notification@skybulls.com"

  def welcome_email(user)
    @user = user
    @url  = "http:www.skybulls.com"
    mail(:to => user.email, :subject => "Welcome to Skybulls")
  end

  def register_email(user,league)
    @user = user
    @league = league
    @url  = "http:www.skybulls.com"

    mail(:to => user.email, :subject => "Registration to league #{league.title} successful")
  end

  def league_start_email(user,league)
    @user = user
    @league = league
    @url  = "http:www.skybulls.com"
    mail(:to => user.email, :subject => "League #{league.title} is about to begin")
  end

  def cash_position_email(ula)
    @ula = ula
    @url  = "http:www.skybulls.com"
    @deposit = Users::Deposit.find_by_user_league_association_id(ula.id)
    mail(:to => user.email, :subject => "Results for SkyBulls league #{league.title}")
  end


end
