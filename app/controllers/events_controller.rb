class EventsController < ApplicationController
  before_filter :authenticate_user, only: [:create, :destroy]

  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def create
    meetup_id = extract_meetup_id(params[:meetup_link])

    if event_params = MeetupService.new.event(meetup_id)
      event = Event.create(event_params.select { |k, _| k.in? permitted_fields }.merge(user: @current_user,
                                                                                       twitter_tag: params[:twitter_tag]))

      # MeetupWorker.perform_async(meetup_id, event.id)
      # TwitterWorker.perform_async(event.twitter_tag, event.id)

      render json: {event: event}, status: :ok
    else
      head :not_found
    end
  end

  def destroy
    Event.find(params[:id]).destroy

    head :ok
  rescue => _e
    head :unprocessable_entity
  end

  private

  def extract_meetup_id(meetup_link)
    meetup_link.match(/events\/(\d+)\//)[1]
  end

  def permitted_fields
    [:name, :description, :meetup_id, :twitter_tag]
  end
end