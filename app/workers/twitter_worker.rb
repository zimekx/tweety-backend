class TwitterWorker
  include Sidekiq::Worker

  def perform(tag, event_id)
    TwitterComment.create(TwitterService.new.search(tag, event_id))
  end
end