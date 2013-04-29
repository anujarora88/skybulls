class DashboardController < Users::AbstractController



  def index
    @leagues =  Array.new
    user_league_association = UserLeagueAssociation.find_all_by_user_id(current_user.id)
    user_league_association.each do |ula|
      @leagues.append(League.find(ula.league_id))
    end

  end

  end
