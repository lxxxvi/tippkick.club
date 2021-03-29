require 'test_helper'

class DashboardProfileComponentTest < ViewComponent::TestCase
  test '.render' do
    component = DashboardProfileComponent.new
    render_inline(component)

    assert_text 'Change Your Profile'
    assert_link 'Profile', href: '/profile'
  end
end
