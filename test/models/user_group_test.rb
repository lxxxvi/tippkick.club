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
end
