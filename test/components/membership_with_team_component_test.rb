require 'test_helper'

class MembershipWithTeamComponentTest < ViewComponent::TestCase
  test '.render' do
    component = MembershipWithTeamComponent.new(
      membership_with_team: users(:diego).memberships_with_teams.first
    )

    render_inline(component).tap do
      assert_selector '.team--name', text: 'Campeones'
      assert_selector '.team--ranking-position'
    end
  end
end
