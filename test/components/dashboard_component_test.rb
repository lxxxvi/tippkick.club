require 'test_helper'

class DashboardComponentTest < ViewComponent::TestCase
  test '#render' do
    component = DashboardComponent.new(user: users(:pele))
    render_inline(component)

    assert_selector 'h1', text: 'Hey pele, this is your dashboard'
    assert_selector '.rules'
    assert_selector 'section', minimum: 1
  end

  test '#title' do
    component = DashboardComponent.new(user: users(:pele))
    assert_equal 'Hey pele, this is your dashboard', component.title
  end
end
