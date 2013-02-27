require 'openid/store/filesystem'

Rails.application.config.middleware.use OmniAuth::Builder do
  # The following is for facebook
  provider :facebook, "169442719870493", "368af9baf42d603bf7f51504a1c1d793", {:scope => 'email, read_stream, read_friendlists, offline_access'}

  # If you want to also configure for additional login services, they would be configured here.
  provider :open_id, :store => OpenID::Store::Filesystem.new('/tmp'), :name => 'google', :identifier => 'https://www.google.com/accounts/o8/id', :require => 'omniauth-openid'
end