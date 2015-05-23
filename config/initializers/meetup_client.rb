MeetupClient.configure do |config|
  config.api_key = APP_CONFIG[:meetup][:api_key]
end