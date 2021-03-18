require 'test_helper'

class RankingPositionComponentTest < ViewComponent::TestCase
  test '.render' do
    component = RankingPositionComponent.new(ranking_position: 15, active_members: 23)
    render_inline(component)
    assert_selector '.ranking-position', text: '15'
    assert_selector '.active-members', text: '23'
  end
end
