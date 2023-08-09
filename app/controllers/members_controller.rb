class MembersController < ApplicationController
  def index
    @members = Members.all
  end

  def create
    @member = Member.new(member_params)
    @member.user = current_user
    if @member.save
      redirect_to @member, notice: 'Member successfully added!'
    else
      render members_path, alert: 'Member not added!'
    end
  end

  private

  def member_params
    params.require(:member).permit(:name, :is_pet)
  end
end
