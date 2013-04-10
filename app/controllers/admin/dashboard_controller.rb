class Admin::DashboardController < Admin::AbstractController


  def index
    @admin = current_admin_user
    respond_to do |format|
      format.html {render :'admin/dashboard/index'}
    end
  end
end
