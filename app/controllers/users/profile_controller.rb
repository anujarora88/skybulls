class Users::ProfileController < Users::AbstractController

  def index
     @registered_leagues = current_user.leagues.order("end_time DESC")
  end

  def update_user_info
    if params[:name] == 'username'
      current_user.user_name= params[:value]
    elsif params[:name] == 'telephone'
      current_user.phone_number = params[:value]
    else
      current_user.attributes = params[:user]
    end
    current_user.save!
    render :inline => "Success!"

  end

  def search
    keywords = params[:keywords]
    @stocks = Stock.joins(:company).where("stocks.symbol LIKE :term OR companies.name LIKE :term", {term: "%#{params[:term]}%"}).all
    respond_to do |format|
      format.json {render json: @stocks.map {|s| {:label => s.to_s, :value => s.symbol_with_exchange, :id => s.id}}}
    end
  end

  def add_pinned_stock
    stock = Stock.find(params[:selected_stock_id])
    if current_user.stocks.include? stock
      current_user.add_pinned_stock(stock)
      render :nothing => true
    else
      current_user.add_pinned_stock(stock)
      render :partial => "pinned_stock", :locals => {:stock => stock}
    end

  end

  def delete_pinned_stock
    stock = Stock.find(params[:id])
    current_user.delete_pinned_stock(stock)
    render :nothing => true
  end



end
