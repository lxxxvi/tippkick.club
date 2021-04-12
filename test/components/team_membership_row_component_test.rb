require 'test_helper'

class TeamMembershipRowComponentTest < ViewComponent::TestCase
  test '.render, before tournament' do
    before_tournament do
      membership = memberships(:diego_campeones)
      component = TeamMembershipRowComponent.new(team_membership_row: membership)

      render_inline(component)

      page.all('td').tap do |td|
        assert_equal 'digi 🇪🇸', td[0].text.strip
      end
    end
  end

  test '.render, in game 1' do
    in_game_1 do
      membership = memberships(:diego_campeones)
      component = TeamMembershipRowComponent.new(team_membership_row: membership)

      render_inline(component)

      page.all('td').tap do |td|
        assert_equal '1', td[0].text.strip
        assert_equal '152', td[1].text.strip
        assert_equal 'digi 🇪🇸', td[2].text.strip
      end
    end
  end
end
