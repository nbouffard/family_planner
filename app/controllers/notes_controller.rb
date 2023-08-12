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
    @noteable = noteable_object
    @user = User.find(params[:user_id])
    @member = Member.find(params[:member_id])
    Rails.logger.debug "Noteable: #{@noteable}"
  Rails.logger.debug "User: #{@user}"
  Rails.logger.debug "Member: #{@member}"
    @note = @noteable.notes.new(notes_params)
    # if @note.noteable.event
    #   @note.member = @member
    # end
    @note.user = current_user
    authorize @note
    if @note.save
      redirect_to user_member_path(@user, @member), notice: 'Note successfully created'
    else
      render :new, alert: "Error: Note could not be created"
    end
  end

  private

  def notes_params
    params.require(:note).permit(:comment)
  end

  def noteable_object
    if params[:member_id] && params[:event_id]
      Event.find(params[:event_id])
    elsif params[:member_id]
      Member.find(params[:member_id])
    end
  end
end
