MailerLite.configure do |config|
  config.api_key = Rails.application.credentials.mailerlite[:api_key]
  # config.timeout = 10
end
