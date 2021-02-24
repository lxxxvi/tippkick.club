require 'test_helper'

class UserGroupTest < ActiveSupport::TestCase
  test 'validates uniqueness of name' do
    user_group = UserGroup.new(name: 'Campeones')

    assert_not user_group.valid?
    assert_includes user_group.errors[:name],
                    'has already been taken'
  end

  test 'users association' do
    user_group = user_groups(:campeones)

    assert_includes user_group.users,
                    users(:diego)
  end

  test '#membership_for' do
    user = users(:diego)
    user_group = user_groups(:campeones)
    membership = memberships(:diego_campeones)

    assert_equal membership, user_group.membership_for(user)
  end

  test '.create_with_user' do
    user = users(:diego)

    assert_difference -> { user.memberships.count }, +1 do
      UserGroup.create_with_user(user, 'Argentinos')
    end

    user_group = UserGroup.find_by(name: 'Argentinos')

    user_group.memberships.tap do |memberships|
      assert_equal 1, memberships.count
      assert_equal user, memberships.first.user
      assert memberships.first.admin?
    end
  end
end
