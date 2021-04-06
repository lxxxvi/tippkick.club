require 'test_helper'

class DashboardTeamsComponentTest < ViewComponent::TestCase
  test '.render' do
    component = DashboardTeamsComponent.new(users(:diego))
    render_inline component
    assert_selector '.description', text: 'You are in 2 teams'
    assert_link 'Teams', href: '/teams'
  end
end
