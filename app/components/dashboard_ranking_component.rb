class DashboardRankingComponent < ViewComponent::Base
  def initialize(user)
    @user = user
  end

  def render?
    Tournament.after_first_kickoff?
  end

  def display_final_ranking?
    Tournament.after_last_final_whistle?
  end
end
