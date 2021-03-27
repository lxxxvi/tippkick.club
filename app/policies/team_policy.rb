class TeamPolicy < ApplicationPolicy
  def show?
    true
  end

  def create?
    show?
  end

  def update?
    coach?
  end

  def destroy?
    coach?
  end

  def leave?
    just_member? && not_global_team?
  end

  def invite?
    coach?
  end

  private

  def not_global_team?
    !record.global?
  end

  def coach?
    membership&.coach?
  end

  def just_member?
    membership.present? && !coach?
  end

  def membership
    @membership ||= record.membership_for(user)
  end
end
