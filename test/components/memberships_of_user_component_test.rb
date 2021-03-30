require 'test_helper'

class MembershipsOfUserComponentTest < ViewComponent::TestCase
  test '.render' do
    component = MembershipsOfUserComponent.new(memberships_of_user: users(:diego).memberships)
    render_inline(component)
    assert_selector 'table.memberships-of-user'
    assert_selector 'table.memberships-of-user tbody tr', minimum: 1
  end
end
