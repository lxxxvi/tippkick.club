require 'test_helper'

class CurrentRankingComponentTest < ViewComponent::TestCase
  test '.render, in_game_1' do
    user = users(:diego)
    Game.update_all(final_whistle_at: nil)

    in_game_1 do
      FinalWhistleService.new.call!
      user.reload
      render_inline DashboardRankingComponent.new(user)
      assert_selector '.points', text: '0', exact_text: true
      assert_selector '.global-ranking', text: '1', exact_text: true
    end
  end

  test '.render, during tournament' do
    before_game_25 do
      component = DashboardRankingComponent.new(users(:diego))

      render_inline(component)
      assert_selector '.points', text: '152'
      assert_selector '.global-ranking', text: '1', exact_text: true

      assert_link 'Global ranking', href: '/teams/global'
    end
  end
end
