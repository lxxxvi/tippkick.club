require 'test_helper'

class ConfirmableComponentTest < ViewComponent::TestCase
  test '#render' do
    render_inline(ConfirmableComponent.new) do |component|
      component.pre { 'Destroy' }
      component.cancel { 'Abort' }
      component.proceed { 'Proceed' }
    end

    assert_selector '.confirmable--pre', text: 'Destroy'
    assert_selector '.confirmable--confirm--cancel', text: 'Abort'
    assert_selector '.confirmable--confirm--proceed', text: 'Proceed'
  end
end
