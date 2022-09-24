class AchievementBarComponent < ViewComponent::Base
  def initialize(bet:)
    @bet = bet
  end

  def render?
    @bet.game.final_whistle?
  end

  def progress_bar_width
    actual_to_max_ratio
  end

  def progress_bar_color_class
    "achievement-bar-component--percentile-#{actual_to_max_percentile}"
  end

  private

  def actual_to_max_percentile
    actual_to_max_ratio.ceil(-1) # 1 -> 10, 11 -> 20, 99 -> 100
  end

  def actual_to_max_ratio
    @actual_to_max_ratio ||= (@bet.total_points.to_f / Game::MAX_TOTAL_POINTS) * 100
  end
end
