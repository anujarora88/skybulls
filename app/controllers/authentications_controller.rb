class AuthenticationsController < Devise::OmniauthCallbacksController

  skip_before_filter :verify_authenticity_token, :only => [:google]

  def google
    auth = request.env["omniauth.auth"]
    data = auth.info
    parse_auth_callback(auth, data["email"])
  end

  def facebook
    auth = request.env["omniauth.auth"]
    parse_auth_callback(auth, auth['extra']['raw_info']['email'])
  end

  private

    def parse_auth_callback(auth, email)

      # Try to find authentication first
      authentication = Authentication.find_by_provider_and_uid(auth['provider'], auth['uid'])

      if authentication
        unless authentication.user.email == email
          user = authentication.user
          user.email = email
          user.save!
        end
        # Authentication found, sign the user in.
        flash[:notice] = "Signed in successfully."
        sign_in_and_redirect(:user, authentication.user)
      else
        # Authentication not found, thus a new user.
        user = User.where(:email => email).first || User.new(:password => Devise.friendly_token[0,20])
        user.apply_omniauth(auth, email)
        if user.save(:validate => false)
          flash[:notice] = "Account created and signed in successfully."
          sign_in_and_redirect(:user, user)
        else
          flash[:error] = "Error while creating a user account. Please try again."
          redirect_to root_url
        end
      end
    end

end
