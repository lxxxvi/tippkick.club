class DashboardRankingComponent < ViewComponent::Base
  def initialize(user)
    @user = user
  end

  def render?
    total_points.present?
  end

  def total_points
    @total_points ||= @user.total_points
  end

  def global_ranking_position
    @global_ranking_position ||= @user.membership_for(Team.global)&.ranking_position
  end
end