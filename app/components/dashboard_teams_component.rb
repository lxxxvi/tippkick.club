class DashboardTeamsComponent < ViewComponent::Base
  def initialize(user)
    @user = user
  end

  def stats_ready?
    @user.total_points.present?
  end

  def number_of_teams
    @number_of_teams ||= @user.teams.count
  end

  def global_ranking_position
    @global_ranking_position ||= @user.membership_for(Team.global)&.ranking_position
  end
end
