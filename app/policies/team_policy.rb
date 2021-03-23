class TeamPolicy < ApplicationPolicy
  def show?
    true
  end

  def create?
    show?
  end

  def edit?
    record.membership_for(user).admin?
  end

  def destroy?
    edit?
  end
end
