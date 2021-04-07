require 'test_helper'

class ProfileFormComponentTest < ViewComponent::TestCase
  test '.render' do
    form = ProfileForm.new(users(:diego))
    component = ProfileFormComponent.new(form)

    render_inline component

    assert_field 'Nickname', with: 'digi'
    assert_select 'Rooting for team', selected: 'Spain 🇪🇸'
  end

  test '.render, form errors' do
    form = ProfileForm.new(users(:diego), nil, { nickname: '' })
    form.save
    component = ProfileFormComponent.new(form)

    render_inline component

    assert_selector '.errors', text: "Nickname can't be blank"
  end
end
