require 'test_helper'

class MembershipTest < ActiveSupport::TestCase
  test 'validates uniqueness of user and user_group' do
    membership = Membership.new(user: users(:diego),
                                user_group: user_groups(:campeones))
    assert_not membership.valid?

    assert_includes membership.errors[:user_id],
                    'has already been taken'
  end

  test '#mark_accepted' do
    membership = memberships(:pele_campeones_invited)

    assert_changes -> { membership.accepted? }, to: true do
      membership.mark_accepted
    end

    assert membership.changes.any?
  end

  test '#accept, #accepted?, .accepted, .invited' do
    membership = memberships(:pele_campeones_invited)
    assert_difference -> { Membership.invited.count }, -1 do
      assert_difference -> { Membership.accepted.count }, 1 do
        assert_changes -> { membership.accepted? }, to: true do
          membership.accept
        end
      end
    end
  end

  test '#leave' do
    membership = memberships(:pele_campeones_invited)

    assert_raises(ActiveRecord::RecordNotFound) do
      membership.leave
      membership.reload
    end
  end
end
