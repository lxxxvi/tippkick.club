require 'test_helper'

class DashboardCardLinkComponentTest < ViewComponent::TestCase
  test '.render' do
    component = DashboardCardLinkComponent.new(name: 'Foo', path: '/foo')
    render_inline component
    assert_link 'Foo', href: '/foo'
  end
end
