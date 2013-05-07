require 'openid/store/filesystem'

Rails.application.config.middleware.use OmniAuth::Builder do
  # The following is for facebook
  provider :facebook, "#{Rails.configuration.facebook_api_key}", "#{Rails.configuration.facebook_api_secret}", {:scope => 'email, read_stream, read_friendlists, offline_access'}

  # If you want to also configure for additional login services, they would be configured here.
  provider :open_id, :store => OpenID::Store::Filesystem.new('/tmp'), :name => 'google', :identifier => 'https://www.google.com/accounts/o8/id', :require => 'omniauth-openid'
end