require 'test_helper'

class NicknameComponentTest < ViewComponent::TestCase
  test '#render, simple, not having titles' do
    render_inline NicknameComponent.new(user: users(:diego))
    assert_selector '.nickname', text: 'digi'
    assert_selector '.rooting-for-team', count: 0
    assert_selector '.titles', count: 0
  end

  test '#render, with rooting for team, not having titles' do
    render_inline NicknameComponent.new(user: users(:diego), rooting_for_team: true)
    assert_selector '.nickname', text: 'digi'
    assert_selector '.rooting-for-team', text: '🇪🇸'
    assert_selector '.titles svg', count: 0
  end

  test '#render, simple, having titles' do
    user = users(:diego)
    user.titles = 3
    render_inline NicknameComponent.new(user: user)
    assert_selector '.nickname', text: 'digi'
    assert_selector '.rooting-for-team', count: 0
    assert_selector '.titles svg', count: 3
  end

  test '#render, with rooting for team, having titles' do
    user = users(:diego)
    user.titles = 3
    render_inline NicknameComponent.new(user: user, rooting_for_team: true)
    assert_selector '.nickname', text: 'digi'
    assert_selector '.rooting-for-team', text: '🇪🇸'
    assert_selector '.titles svg', count: 3
  end
end
