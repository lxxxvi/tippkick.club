class DashboardService
  def initialize(user)
    @user = user
  end

  def stats_ready?
    total_points.present?
  end

  def total_points
    @total_points ||= @user.total_points
  end

  def unpredicted_predictable_games
    @unpredicted_predictable_games ||= @user.predictions.unpredicted_predictable
  end
end
