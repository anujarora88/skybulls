SkybullsRails::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = true

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  # Raise exception on mass assignment protection for Active Record models
  config.active_record.mass_assignment_sanitizer = :strict

  # Log the query plan for queries taking more than this (works
  # with SQLite, MySQL, and PostgreSQL)
  config.active_record.auto_explain_threshold_in_seconds = 0.5

  # Do not compress assets
  config.assets.compress = false

  config.paypal_merchant_account_email = "anuj@skybulls.com"
  config.paypal_preapproval_key_url = "https://www.sandbox.paypal.com/webscr&cmd=_ap-preapproval&preapprovalkey="

  config.nodeapp_url = "http://skybulls-local.com:8082"
  config.nodeapp_api_key = "sajdnbjkasdasmdnjasdasd"
  config.nodeapp_api_secret = "madnsmndmasdnamdasasdasdd"

  config.facebook_api_key = "170048139825281"
  config.facebook_api_secret = "ae1cfe86b09ddd205412dfd780efe00d"

  # Expands the lines which load the assets
  config.assets.debug = true
  config.action_mailer.default_url_options = { :host => 'localhost:3000' }
end

ActionMailer::Base.smtp_settings = {
    :enable_starttls_auto => true,
    :address => "smtp.gmail.com",
    :port => "587",
    :domain => "skybulls.com",
    :authentication => :plain,
    :user_name => "sysadmin@skybulls.com",
    :password => "skybulls12#"
}

Braintree::Configuration.environment = :sandbox
Braintree::Configuration.merchant_id = "dnjcg8gfyjdb8f6v"
Braintree::Configuration.public_key = "737xnj4ywxdnsq3n"
Braintree::Configuration.private_key = "7786cf405e5d8b908364a809eb52241f"

OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

