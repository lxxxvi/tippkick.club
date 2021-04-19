require 'test_helper'

class MembershipsOfUserComponentTest < ViewComponent::TestCase
  test '#render, before_tournament does not show ranking' do
    before_tournament do
      component = MembershipsOfUserComponent.new(memberships_of_user: users(:diego).memberships)
      render_inline(component)
      assert_selector 'ul.memberships-of-user'
      assert_selector 'ul.memberships-of-user li', minimum: 1
      assert_selector '.ranking', count: 0
    end
  end

  test '#render, in_game_1 shows ranking' do
    in_game_1 do
      component = MembershipsOfUserComponent.new(memberships_of_user: users(:diego).memberships)
      render_inline(component)
      assert_selector '.ranking', minimum: 1
    end
  end
end
