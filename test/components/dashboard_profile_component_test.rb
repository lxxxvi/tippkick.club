require 'test_helper'

class DashboardProfileComponentTest < ViewComponent::TestCase
  test '.render' do
    before_game_25 do
      component = DashboardProfileComponent.new
      render_inline(component)

      assert_text 'Change your profile'
      assert_link 'Profile', href: '/profile'
    end
  end

  test '.render, not after kickoff of game 51 (final)' do
    at_kickoff_of_game_51 do
      assert_not DashboardProfileComponent.new.render?, 'should not render anymore at kickoff of final'
    end
  end
end
