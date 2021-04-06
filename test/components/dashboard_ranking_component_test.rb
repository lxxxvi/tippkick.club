require 'test_helper'

class DashboardRankingComponentTest < ViewComponent::TestCase
  test '.render, before tournament' do
    user = users(:diego)
    user.update_column(:total_points, nil)
    render_inline DashboardRankingComponent.new(users(:diego))
    assert_empty page.text
  end

  test '.render, during tournament' do
    before_game_25 do
      component = DashboardRankingComponent.new(users(:diego))

      render_inline(component)
      assert_text 'You are at position 1 in the global ranking'
      assert_link 'Global Ranking', href: '/teams/global'
    end
  end
end
