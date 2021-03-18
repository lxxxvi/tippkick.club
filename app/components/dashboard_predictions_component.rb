class DashboardPredictionsComponent < ViewComponent::Base
  def initialize(dashboard:)
    @dashboard = dashboard
  end

  def render?
    @dashboard.unpredicted_predictable_games.any?
  end
end
