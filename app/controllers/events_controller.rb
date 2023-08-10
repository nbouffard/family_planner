class EventsController < ApplicationController
  def new
    @member = Member.find(params[:member_id])
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.member = Member.find(params[:member_id])
    if @event.save
      redirect_to member_event_path(@event), notice: 'Event created successfully'
    else
      render :new, alert: 'Event not created'
    end
  end

  def show
    # used member id to find the event as member id and id are inverted on the url
    @event = Event.find(params[:member_id])

  end

  private

  def event_params
    params.require(:event).permit(:title, :time, :date, :address, :vaccination, :flea_treament, :worm_treatment)
  end
end
