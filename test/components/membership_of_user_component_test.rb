require 'test_helper'

class MembershipOfUserComponentTest < ViewComponent::TestCase
  test '.render' do
    component = MembershipOfUserComponent.new(
      membership_of_user: memberships(:diego_campeones)
    )

    render_inline(component).tap do
      assert_selector '.team--name', text: 'Campeones'
      assert_selector '.team--ranking-position'
    end
  end
end
