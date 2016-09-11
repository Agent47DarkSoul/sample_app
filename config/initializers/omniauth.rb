SampleApp::Application.config.middleware.use OmniAuth::Builder do
  provider :flowdock, ENV['FLOWDOCK_CLIENT_ID'], ENV['FLOWDOCK_CLIENT_SECRET'], scope: 'profile flow integration'
end
