class TeamMembershipRowComponent < ViewComponent::Base
  def initialize(team_membership_row:, user: nil)
    @team_membership_row = team_membership_row
    @user = user
  end

  def bg_color_class
    return "bg-blue-300" if team_membership_of_user?
  end

  def team_membership_user
    @team_membership_user ||= @team_membership_row.user
  end

  def render_ranking_and_points?
    Tournament.after_first_kickoff?
  end

  def render_user_total_points_history?
    render_ranking_and_points? && !@team_membership_row.team.global?
  end

  private

  def team_membership_of_user?
    team_membership_user == @user
  end
end
