SkybullsRails::Application.configure do


  config.paypal_merchant_account_email = "anuj@skybulls.com"
  config.paypal_preapproval_key_url = "https://www.sandbox.paypal.com/webscr&cmd=_ap-preapproval&preapprovalkey="

  config.action_mailer.raise_delivery_errors = true

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  # Raise exception on mass assignment protection for Active Record models
  config.active_record.mass_assignment_sanitizer = :strict


  # Expands the lines which load the assets
  config.action_mailer.default_url_options = { :host => 'www.skybulls.com' }
  config.nodeapp_url = "http://node.skybulls.com"

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


