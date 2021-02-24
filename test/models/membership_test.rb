require 'test_helper'

class MembershipTest < ActiveSupport::TestCase
  test 'validates uniqueness of user and user_group' do
    membership = Membership.new(user: users(:diego),
                                user_group: user_groups(:campeones))
    assert_not membership.valid?

    assert_includes membership.errors[:user_id],
                    'has already been taken'
  end
end
