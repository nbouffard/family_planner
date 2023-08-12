class NotesController < ApplicationController
  def new
    if params[:event_id]
      @event = Event.find(params[:event_id])
      @user = User.find(params[:user_id])
      @member = Member.find(params[:member_id])
    else
      @user = User.find(params[:user_id])
      @member = Member.find(params[:member_id])
    end
    @noteable = noteable_object
    @note = @noteable.notes.new()
    authorize @note
  end

  def create
    # @noteable = noteable_object
    @user = User.find(params[:user_id])
    @member = Member.find(params[:member_id])
    if params[:event_id]
      @noteable = Event.find(params[:event_id])
      noteable_type = 'Event'
    else
      @noteable = @member
      noteable_type = 'Member'
    end
    @note = @noteable.notes.new(notes_params)
    @note.user = current_user
    @note.noteable_type = noteable_type
    authorize @note
    if @note.save
      redirect_to user_member_path(@user, @member), notice: 'Note successfully created'
    else
      render :new, alert: "Error: Note could not be created"
    end
  end

  # def create
  #   @user = User.find(params[:user_id])
  #   @member = Member.find(params[:member_id])

  #   if params[:event_id]
  #     @member = Member.find(params[:member_id])
  #     @event = @member.events.find(params[:event_id]) # Fetch the event using event_id
  #     @noteable = @event # Set the noteable to the event
  #   else
  #     @noteable = @member # Set the noteable to the member
  #   end

  #   @note = @noteable.notes.new(notes_params)
  #   @note.user = current_user
  #   authorize @note

  #   if @note.save
  #     redirect_to user_member_path(@user, @member), notice: 'Note successfully created'
  #   else
  #     render :new, alert: "Error: Note could not be created"
  #   end
  # end

  private

  def notes_params
    params.require(:note).permit(:comment)
  end

  def noteable_object
    # raise
    if params[:event_id]
      Event.find(params[:event_id])
    elsif params[:member_id]
      Member.find(params[:member_id])
    end
  end
end
