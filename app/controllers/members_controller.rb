class MembersController < ApplicationController
  before_action :set_user
  def show
    # @user = User.find(params[:user_id])
    @member = Member.find(params[:id])
    # @events = Event.where(member_id: @member)
    authorize @member
  end

  def new
    @member = Member.new
    authorize @member
  end

  def create
    # @user = Member.find(params[:user])
    @member = Member.new(member_params)
    @member.user = current_user
    authorize @member
    if @member.save
      redirect_to user_member_path(current_user, @member), notice: 'Member successfully added!'
    else
      render :new, alert: 'Member not added!'
    end
  end

  private

  def member_params
    params.require(:member).permit(:name, :is_pet)
  end

  def set_user
    @user = User.find(params[:user_id])
  end
end
