class Users::ProfileController < ApplicationController

    def update_user_info
      if params[:id] == 'username'
        current_user.user_name= params[:value]
      end

      respond_to do |format|
        format.json { render json: "success" }
      end

    end

end
