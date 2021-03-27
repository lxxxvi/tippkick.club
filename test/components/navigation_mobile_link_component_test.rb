require 'test_helper'

class NavigationMobileLinkComponentTest < ViewComponent::TestCase
  test '.render' do
    component = NavigationLinkComponent.new('Foo', '/bar')
    render_inline(component)
    assert_link 'Foo', href: '/bar'
  end
end
