class MembershipRankingComponent < ViewComponent::Base
  def initialize(team:, user:)
    @team = team
    @user = user
  end

  def render?
    ranked? && Tournament.after_first_kickoff?
  end

  def team_membership
    @team_membership ||= @team.membership_for(@user)
  end

  def ranked?
    team_membership&.ranking_position?
  end
end
