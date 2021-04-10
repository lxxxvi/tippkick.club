class DashboardPredictionsComponent < ViewComponent::Base
  def initialize(user)
    @user = user
  end

  def all_set?
    unpredicted_predictable_games_count.zero?
  end

  def unpredicted_predictable_games_count
    @unpredicted_predictable_games_count ||= @user.predictions.unpredicted_predictable.count
  end
end
