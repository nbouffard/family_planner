class MembersController < ApplicationController
  def index
    @members = Member.all
  end

  def show
    @member = Member.find(params[:id])
  end

  def new
    @member = Member.new
  end

  def create
    # @user = Member.find(params[:user])
    @member = Member.new(member_params)
    @member.user = current_user
    if @member.save
      redirect_to member_path(@member), notice: 'Member successfully added!'
    else
      render :new, alert: 'Member not added!'
    end
  end

  private

  def member_params
    params.require(:member).permit(:name, :is_pet)
  end
end
