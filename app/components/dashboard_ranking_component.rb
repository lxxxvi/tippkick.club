class DashboardRankingComponent < ViewComponent::Base
  def initialize(user)
    @user = user
  end

  def render?
    @user.total_points.present?
  end

  def global_ranking_position
    @global_ranking_position ||= @user.membership_for(Team.global)&.ranking_position
  end
end
