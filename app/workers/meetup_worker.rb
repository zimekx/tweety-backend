class MeetupWorker
  include Sidekiq::Worker

  def perform(meetup_id, event_id)
    MeetupComment.create(MeetupService.new.event_comments(meetup_id, event_id))
  end
end