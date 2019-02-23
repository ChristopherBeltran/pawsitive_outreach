Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['2233509133588204'],
    ENV['91eab635b097d4fb6e18b0f4c6c9ca8e']
end
