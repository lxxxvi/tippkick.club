require 'test_helper'

class TeamMembershipComponentTest < ViewComponent::TestCase
  test '.render' do
    membership = memberships(:diego_campeones)
    component = TeamMembershipComponent.new(
      team_membership: membership
    )

    render_inline(component).tap do
      assert_selector '.team-membership--user--nickname', text: 'digi'
      assert_selector '.team-membership--user--total-points', text: '152'
      assert_selector '.team-membership--ranking-position', text: '1'
    end
  end
end
