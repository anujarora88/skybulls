class Users::LeagueRegistrationController < Users::AbstractController

  def show_league_info
    @league= League.find(params[:id])
    respond_to do |format|
      format.js {render :partial => 'dashboard/league_info'}
    end

  end

  def register
    @league = League.find(params[:id])
    if UserLeagueAssociation.find_by_user_id_and_league_id(current_user.id,@league.id).nil?
      UserLeagueAssociation.create(:user_id => current_user.id, :league_id=>@league.id)
    end

    respond_to do |format|
      format.js {render :partial => 'dashboard/league_register'}
    end
  end

end
