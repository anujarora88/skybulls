class User::LeagueRegistrationController < ApplicationController

  def show_league_info
    @league= League.find(params[:id])
    respond_to do |format|
      format.json { render json: @league }
    end
  end

  def register
    league = League.find(params[:id])
    if UserLeagueAssociation.find_by_user_id_and_league_id(current_user.id,league.id).nil?
      UserLeagueAssociation.create(:user_id => current_user.id, :league_id=>league.id)
    end

    respond_to do |format|
      format.html { redirect_to dashboard_path }
    end
  end

end
