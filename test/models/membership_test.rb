require 'test_helper'

class MembershipTest < ActiveSupport::TestCase
  test 'validates uniqueness of user and team' do
    membership = Membership.new(user: users(:diego),
                                team: teams(:campeones))
    assert_not membership.valid?

    assert_includes membership.errors[:user_id],
                    'has already been taken'
  end

  test '#leave' do
    membership = memberships(:pele_campeones)

    assert_difference -> { Membership.count }, -1 do
      membership.leave
    end

    assert_raises(ActiveRecord::RecordNotFound) do
      membership.reload
    end
  end
end
