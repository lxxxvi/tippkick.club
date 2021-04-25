require 'test_helper'

class AchievementBarComponentTest < ViewComponent::TestCase
  test '#render' do
    component = AchievementBarComponent.new(actual_points: 4, maximum_points: 7)
    render_inline component

    assert_text 'You scored 4 out of 7 points'
    assert_in_delta component.progress_bar_width, 57.1, 0.1
    assert_equal 'achievement-bar-component--percentile-60', component.progress_bar_color_class
  end
end
