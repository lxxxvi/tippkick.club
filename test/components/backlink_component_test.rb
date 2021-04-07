require 'test_helper'

class BacklinkComponentTest < ViewComponent::TestCase
  test '#render' do
    component = BacklinkComponent.new(name: 'Foo', path: '/foo')
    render_inline component
    assert_link 'Foo', href: '/foo'
  end
end
