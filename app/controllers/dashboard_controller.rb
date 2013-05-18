class DashboardController < Users::AbstractController



  def index
    @registered_leagues = current_user.leagues.where(completed: false).order("end_time")
  end

  def fetch_notification
    @notifications = Notification.find_all_by_user_id_and_read(params[:id],false)
    render :partial => "dashboard/fetch_notification"
  end

  def dismiss_notification
    notification = Notification.find_by_id(params[:id])
    notification.read= true
    notification.save
    render :json => Notification.find_all_by_user_id_and_read(current_user.id,false).count
=begin
    respond_to do |format|
      format.js { render { :only => :name }.to_json }
    end
=end
  end
end
