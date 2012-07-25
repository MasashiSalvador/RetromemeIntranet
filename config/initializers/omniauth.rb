Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '397893486935947','c52367963642e06c8f99cc585b507dfd'
end