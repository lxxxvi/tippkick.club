require 'test_helper'

class DashboardCardComponentTest < ViewComponent::TestCase
  test '.render' do
    render_inline(DashboardCardComponent.new) do |c|
      c.icon { '<svg></svg>' }
      c.description { 'Cool, Cool' }
      c.link(name: 'Cool', path: '/cool')
    end

    assert_selector '.icon'
    assert_selector '.description', text: 'Cool, Cool'
    assert_link 'Cool', href: '/cool'
  end
end
