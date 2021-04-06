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
      assert_selector '.points', text: '152'
      assert_selector '.global-ranking', text: '1', exact_text: true

      assert_link 'Global Ranking', href: '/teams/global'
    end
  end
end
