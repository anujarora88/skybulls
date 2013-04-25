class Admin::AbstractController < ApplicationController

  prepend_before_filter :authenticate_admin_user!

  layout 'admin/admin'
end
