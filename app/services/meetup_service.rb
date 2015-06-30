include ActionView::Helpers::SanitizeHelper

class MeetupService
  attr_reader :client

  def initialize
    @client = MeetupApi.new
  end

  def event(meetup_id)
    return fake_event(meetup_id)

    response = client.events(event_id: meetup_id)

    if response['results'].present?
      event = response['results'][0]
      parse_event(event)
    else
      nil
    end
  end

  def event_comments(meetup_id, event_id)
    client.event_comments(event_id: meetup_id)['results'].map do |comment|
      parse_comment(event_id, comment)
    end
  end

  def events(events_ids)
    events = client.events(event_id: events_ids.join(','))['results']
    events.map { |event| parse_event(event) }
  end

  private

  def parse_comment(event_id, c)
    {
      event_id: event_id,
      external_source_id: c['event_comment_id'],
      content: c['comment'],
      external_user_name: c['member_name'],
      external_user_id: c['member_id']
    }
  end

  def fake_event(meetup_id)
    {
      name: Faker::Lorem.sentence,
      description: Faker::Lorem.paragraph,
      participants: rand(1000),
      meetup_id: meetup_id,
      start_time: Faker::Time.forward(14, :evening).to_i,
      url: Faker::Internet.url('meetup.com'),
      group: Faker::Lorem.sentence,
      group_url: Faker::Internet.url('meetup.com')
    }
  end

  def parse_event(e)
    {
      venue: e['venue'],
      name: e['name'],
      description: strip_tags(e['description']),
      participants: e['yes_rsvp_count'],
      meetup_id: e['id'],
      start_time: e['time'] / 1000,
      url: e['event_url'],
      group: e['group']['name'],
      group_url: e['group']['urlname']
    }
  end
end