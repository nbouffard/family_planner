class MemberPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
  def show?
    user.present? && user == record.user
  end

  def new?
    create?
  end

  def create?
    user.present?
  end
end
