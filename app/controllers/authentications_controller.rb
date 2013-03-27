class AuthenticationsController < Devise::OmniauthCallbacksController

  skip_before_filter :verify_authenticity_token, :only => [:google]

  def google
    auth = request.env["omniauth.auth"]
    data = auth.info
    parse_auth_callback(auth, data["email"], request.env["omniauth.params"])
  end

  def facebook
    auth = request.env["omniauth.auth"]
    parse_auth_callback(auth, auth['extra']['raw_info']['email'], request.env["omniauth.params"])
  end

  private

    def parse_auth_callback(auth, email, omniauth_params)

      # Try to find authentication first
      authentication = Authentication.find_by_provider_and_uid(auth['provider'], auth['uid'])

      if authentication
        unless authentication.user.email == email
          user = authentication.user
          user.email = email
          user.skip_confirmation!
          user.save!
        end
        # Authentication found, sign the user in.
        flash[:notice] = "Signed in successfully."
        sign_in_and_redirect(:user, authentication.user)
      else
        # Authentication not found, thus a new user.  TODO maybe show a message
        if omniauth_params.with_indifferent_access[:signup]
          user = User.where(:email => email).first || User.new(:password => Devise.friendly_token[0,20])
          user.apply_omniauth(auth, email)
          user.skip_confirmation!
          if user.save(:validate => false)
            flash[:notice] = "Account created and signed in successfully."
            sign_in_and_redirect(:user, user)
          else
            flash[:error] = "Error while creating a user account. Please try again."
            redirect_to new_user_session_path
          end
        else
          flash[:error] = "User not found!!."
          redirect_to new_user_session_path
        end

      end
    end

end
