class NotesController < ApplicationController
  def new
    if params[:event_id]
      @event = Event.find(params[:event_id])
      set_user_member
    else
      set_user_member
    end
    @noteable = noteable_object
    @note = @noteable.notes.new()
    authorize @note
  end

  def create
    # @noteable = noteable_object
    set_user_member
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

  def destroy
    set_user_member
    if params[:event_id]
      @event = Event.find(params[:event_id])
      @note = @event.notes.find(params[:id])
    else
      @note = @member.notes.find(params[:id])
    end
    @note.destroy
    redirect_to root_path, notice: 'Note successfully deleted'
  end

  private

  def notes_params
    params.require(:note).permit(:comment)
  end

  def set_user_member
    @user = User.find(params[:user_id])
    @member = Member.find(params[:member_id])
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
