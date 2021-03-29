require 'test_helper'

class MembershipsOfUserComponentTest < ViewComponent::TestCase
  test '.render' do
    component = MembershipsOfUserComponent.new(memberships_of_user: users(:diego).memberships)
    render_inline(component)
    assert_selector '.teams .team', minimum: 1
    assert_selector '.teams .create-team', count: 1
  end
end
