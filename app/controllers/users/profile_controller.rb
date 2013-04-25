class Users::ProfileController < Users::AbstractController

    def update_user_info
      if params[:id] == 'username' || params[:id] == 'email' || params[:id] == 'password'
        current_user.user_name= params[:value]
      else
        if current_user.profile.nil?
          current_user.profile = Profile.new
          profile.save
        end
        current_user.profile.phone_number = params[:value]
      end
      current_user.save
      respond_to do |format|
        format.html { render json: {'success'=>'success'}}
      end

    end

    def update_user_photo
       user = current_user
    end

end
