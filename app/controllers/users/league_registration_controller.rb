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

  def pin_stock
    stock = Stock.find(params[:id])
    stock_pinned = current_user.add_pinned_stock(stock)
  end

  def search_stocks
    @stock = Stock.find_all_by_symbol(params[:symbol])
    respond_to do |format|
      format.js {render :partial => 'users/stock_list_html' }
    end
  end

end
