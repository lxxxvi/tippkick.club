require 'test_helper'

class NicknameComponentTest < ViewComponent::TestCase
  test '.render, default' do
    user = users(:diego)
    render_inline(NicknameComponent.new(user: user))

    assert_selector '.nickname--nickname', text: 'digi'
    assert_selector 'button', text: 'Change Nickname'
  end

  test '.render, open form' do
    user = users(:diego)
    render_inline(NicknameComponent.new(user: user, open_form: true))

    assert_selector '.nickname--form'
    assert_field 'nickname', with: 'digi'
    assert_selector 'button', text: 'Save'
    assert_selector 'button', text: 'Cancel'
  end

  test '.render, erros' do
    user = users(:diego)
    user.update(nickname: 'pele')
    render_inline(NicknameComponent.new(user: user))

    assert_selector '.nickname--form'
    assert_field 'nickname', with: 'pele'
    assert_selector '.errors', text: 'Nickname has already been taken'
  end
end
