class TeamPolicy < ApplicationPolicy
  def show?
    true
  end

  def create?
    show?
  end

  def update?
    record.membership_for(user).admin?
  end

  def destroy?
    update?
  end
end
