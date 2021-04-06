require 'test_helper'

class DashboardTeamsComponentTest < ViewComponent::TestCase
  test '.render, before tournament' do
    user = users(:diego)
    user.update_column(:total_points, nil)
    before_tournament do
      component = DashboardTeamsComponent.new(users(:diego))

      render_inline(component)
      assert_text 'You are in 2 teams'
      assert_link 'Teams', href: '/teams'
    end
  end

  test '.render, during tournament' do
    before_game_25 do
      component = DashboardTeamsComponent.new(users(:diego))

      render_inline(component)
      assert_text 'You are at position 1 in the global ranking'
      assert_link 'Teams', href: '/teams'
    end
  end
end
