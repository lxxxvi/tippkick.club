class DashboardPredictionsComponent < ViewComponent::Base
  def initialize(user)
    @user = user
  end

  def all_set?
    unpredicted_predictable_games_count == 0
  end

  def unpredicted_predictable_games_count
    @unpredicted_predictable_games_count ||= unpredicted_predictable_games.count
  end

  private

  def unpredicted_predictable_games
    @unpredicted_predictable_games ||= @user.predictions.unpredicted_predictable
  end
end
