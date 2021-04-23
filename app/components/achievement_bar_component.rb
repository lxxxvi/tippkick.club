class AchievementBarComponent < ViewComponent::Base
  def initialize(actual_points:, maximum_points:)
    @actual_points = actual_points
    @maximum_points = maximum_points
  end

  def render?
    @maximum_points.to_i.positive?
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
    @actual_to_max_ratio ||= (@actual_points.to_f / @maximum_points) * 100
  end
end
