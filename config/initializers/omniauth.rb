Rails.application.config.middleware.use OmniAuth::Builder do
  #to release
  #provider :facebook, '397893486935947','c52367963642e06c8f99cc585b507dfd'
  #to test
  provider :facebook, '250814918369249', '71f405e2f1340cd473c43a59aca622ad'
end