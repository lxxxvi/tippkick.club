class MembershipWithTeamComponent < ViewComponent::Base
  def initialize(membership_with_team:)
    @membership_with_team = membership_with_team
  end
end
