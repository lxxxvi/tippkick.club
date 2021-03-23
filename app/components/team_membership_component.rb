class TeamMembershipComponent < ViewComponent::Base
  def initialize(team_membership:)
    @team_membership = team_membership
  end
end
