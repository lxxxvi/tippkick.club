require 'test_helper'

class RankingPositionComponentTest < ViewComponent::TestCase
  test '.render' do
    component = RankingPositionComponent.new(ranking_position: 15, members_count: 23)
    render_inline(component)
    assert_selector '.ranking-position', text: '15'
    assert_selector '.members-count', text: '23'
  end
end
