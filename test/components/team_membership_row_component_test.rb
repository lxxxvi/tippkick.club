require 'test_helper'

class TeamMembershipRowComponentTest < ViewComponent::TestCase
  test '.render' do
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
