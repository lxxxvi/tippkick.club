class TeamPolicy < ApplicationPolicy
  def show?
    true
  end

  def create?
    show?
  end

  def update?
    membership.coach?
  end

  def destroy?
    update?
  end

  def leave?
    membership.present? && !update?
  end

  private

  def membership
    @membership ||= record.membership_for(user)
  end
end
