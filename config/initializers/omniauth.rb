Rails.application.config.middleware.use OmniAuth::Builder do
  #provider :facebook, ENV['FACEBOOK_APP_ID'], ENV['FACEBOOK_APP_SECRET']
  provider :google_oauth2, "409520928239-s604sk4fdnkme8mo447d110hmt2snbt0.apps.googleusercontent.com", "mZ4ABOOCvbsrM_6a5Q_ZTJIJ", {:provider_ignores_state => true}

end

OmniAuth.config.full_host = Rails.env.production? ? 'https://domain.com' : 'http://localhost:3000'
