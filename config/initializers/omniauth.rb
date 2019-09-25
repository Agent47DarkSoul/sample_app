OmniAuth.config.logger = Rails.logger

SampleApp::Application.config.middleware.use OmniAuth::Builder do
  provider :flowdock, ENV['FLOWDOCK_CLIENT_ID'], ENV['FLOWDOCK_CLIENT_SECRET'], scope: 'flow profile integration'
end
