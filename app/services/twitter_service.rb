class TwitterService
  attr_reader :client

  def initialize
    @client = init_client
  end

  def search(tag, event_id = 1)
    client.search("##{tag}", search_options).take(10).map { |tweet| parse_tweet(tweet, event_id) }
  end

  private

  def parse_tweet(t, event_id = 1)
    {
      event_id: event_id,
      source_id: t.id,
      content: t.text,
      author_name: t.user.name
    }
  end

  def init_client
    Twitter::REST::Client.new do |config|
      config.consumer_key = APP_CONFIG[:twitter][:consumer_key]
      config.consumer_secret = APP_CONFIG[:twitter][:consumer_secret]
      config.access_token = APP_CONFIG[:twitter][:access_token]
      config.access_token_secret = APP_CONFIG[:twitter][:access_secret]
    end
  end

  def search_options
    {result_type: 'recent', lang: 'pl'}
  end
end