class CurrentRankingComponent < ViewComponent::Base
  def initialize(user)
    @user = user
  end

  def render?
    !Tournament.after_last_final_whistle?
  end

  def total_points
    @total_points ||= @user.total_points
  end

  def global_ranking_position
    @global_ranking_position ||= @user.membership_for(Team.global)&.ranking_position
  end
end
