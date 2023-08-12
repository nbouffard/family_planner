class EventPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end

  def new?
    create?
  end

  def create?
    user && record.member.user == user
  end

  def show?
    user && record.member.user == user
  end

  def destroy?
    user && record.member.user == user
  end
end
