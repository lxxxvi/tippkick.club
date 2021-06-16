require 'test_helper'

class TeamMembershipRowComponentTest < ViewComponent::TestCase
  test '.render, before tournament' do
    before_tournament do
      membership = memberships(:diego_campeones)
      component = TeamMembershipRowComponent.new(team_membership_row: membership)

      render_inline(component)

      assert_selector '.nickname', text: 'digi'
      assert_selector '.rooting-for-team', text: '🇪🇸'
    end
  end

  test '.render, in game 1' do
    in_game_1 do
      membership = memberships(:diego_campeones)
      component = TeamMembershipRowComponent.new(team_membership_row: membership)

      render_inline(component)

      assert_selector '.ranking-position', text: '1'
      assert_selector '.total-points', text: '152'
      assert_selector '.nickname', text: 'digi'
    end
  end
end
