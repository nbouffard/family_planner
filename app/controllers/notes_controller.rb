class NotesController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @member = Member.find(params[:member_id])
    @noteable = noteable_object
    @note = @noteable.notes.new()
    authorize @note
  end

  def create
    @noteable = noteable_object
    @user = User.find(params[:user_id])
    @member = Member.find(params[:member_id])
    @note = @noteable.notes.new(notes_params)
    authorize @note
    if @note.save
      redirect_to @noteable, notice: 'Note successfully created'
    else
      redirect_to @noteable, alert: "Error: Note could not be created"
    end
  end

  private

  def notes_params
    params.require(:note).permit(:comment)
  end

  def noteable_object
    if params[:member_id]
      Member.find(params[:member_id])
    elsif params[:event_id]
      Event.find(params[:event_id])
    end
  end
end
