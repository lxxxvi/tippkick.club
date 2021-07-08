require 'test_helper'

class DashboardRankingComponentTest < ViewComponent::TestCase
  test '.render, before tournament' do
    before_tournament do
      render_inline DashboardRankingComponent.new(users(:diego))
      assert_empty page.text
    end
  end

  test '.render, before last final whistle' do
    in_game_1 do
      render_inline DashboardRankingComponent.new(users(:diego))
      assert_selector '.points', text: '152'
      assert_selector '.global-ranking', text: '1'
    end
  end

  test '.render, after last final whistle' do
    end_tournament!

    after_tournament do
      render_inline DashboardRankingComponent.new(users(:diego))
      assert_text 'Your final global ranking'
      assert_text '1'
    end
  end
end
