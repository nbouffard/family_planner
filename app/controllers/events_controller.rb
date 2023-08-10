class EventsController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @member = Member.find(params[:member_id])
    @event = Event.new
    authorize @event
  end

  def create
    @event = Event.new(event_params)
    @event.member = params[:member_id]
    @member = params[:member_id]
    @user = params[:user_id]
    authorize @event
    if @event.save
      redirect_to user_member_event_path(@user, @member, @event), notice: 'Event created successfully'
    else
      render :new, alert: 'Event not created'
    end
  end

  def show
    # used member id to find the event as member id and id are inverted on the url
    @event = Event.find(params[:id])
    @user = User.find(params[:user_id])
    @member = Member.find(params[:member_id])
    authorize @event
  end

  private

  def event_params
    params.require(:event).permit(:title, :time, :date, :address, :vaccination, :flea_treament, :worm_treatment)
  end
end
