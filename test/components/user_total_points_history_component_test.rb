require 'test_helper'

class UserTotalPointsHistoryComponentTest < ViewComponent::TestCase
  test '#render' do
    before_game_25 do
      component = UserTotalPointsHistoryComponent.new(user: users(:diego))
      render_inline(component)

      assert_selector '.user-total-points-history-table', count: 1
      assert_selector '.user-total-points-history-table--header-row', count: 1
      assert_selector '.user-total-points-history-table--body-row', count: 24
    end
  end
end
