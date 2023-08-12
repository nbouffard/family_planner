class NotePolicy < ApplicationPolicy
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
    record.noteable.instance_of?(Event) ? user && record.noteable.member.user_id == user.id : user && record.noteable.user == user
  end

  def destroy?
    create?

  end
end
