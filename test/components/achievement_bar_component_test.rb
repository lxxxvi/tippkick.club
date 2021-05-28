require 'test_helper'

class AchievementBarComponentTest < ViewComponent::TestCase
  test '#render' do
    before_game_25 do
      bet = bets(:diego_game_1)

      bet.total_points = 0
      component = AchievementBarComponent.new(bet: bet)
      render_inline component
      assert_text 'You scored 0 points'
      assert_equal 0, component.progress_bar_width
      assert_equal 'achievement-bar-component--percentile-0', component.progress_bar_color_class

      bet.total_points = 1
      component = AchievementBarComponent.new(bet: bet)
      render_inline component
      assert_text 'You scored 1 point'
      assert_in_delta component.progress_bar_width, 16.6, 0.1
      assert_equal 'achievement-bar-component--percentile-20', component.progress_bar_color_class

      bet.total_points = 3
      component = AchievementBarComponent.new(bet: bet)
      render_inline component
      assert_text 'You scored 3 points'
      assert_equal 50, component.progress_bar_width
      assert_equal 'achievement-bar-component--percentile-50', component.progress_bar_color_class

      bet.total_points = 4
      component = AchievementBarComponent.new(bet: bet)
      render_inline component
      assert_text 'You scored 4 points'
      assert_in_delta component.progress_bar_width, 66.6, 0.1
      assert_equal 'achievement-bar-component--percentile-70', component.progress_bar_color_class

      bet.total_points = 6
      component = AchievementBarComponent.new(bet: bet)
      render_inline component
      assert_text 'You scored 6 points'
      assert_equal 100, component.progress_bar_width
      assert_equal 'achievement-bar-component--percentile-100', component.progress_bar_color_class
    end
  end

  test '#render, not if final_whistle_at is not past' do
    bet = bets(:diego_game_1)
    assert_changes -> { AchievementBarComponent.new(bet: bet).render? }, to: false do
      bet.game.update_column(:final_whistle_at, nil)
    end
  end
end
