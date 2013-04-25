class DashboardController < Users::AbstractController



  def index
    @league =  Array.new
    user_league_association = UserLeagueAssociation.find_all_by_user_id(current_user.id)
    user_league_association.each do |ula|
      @league.append(League.find(ula.league_id))
    end
      respond_to do |format|
        format.html {render :'users/user_profile'}
      end
    end

  end
