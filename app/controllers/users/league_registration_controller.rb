class Users::LeagueRegistrationController < Users::AbstractController

  layout "popup"

  helper :leagues

  def show_league_info
    @league= League.find(params[:id])

  end

  def register
    @league = League.find(params[:id])
    if UserLeagueAssociation.find_by_user_id_and_league_id(current_user.id,@league.id).nil?
        if current_user.account.balance < @league.total_buy_in_cost
          @error_message = "Not enough balance"
        else
          UserLeagueAssociation.create!(:user => current_user, :league => @league)
        end

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
