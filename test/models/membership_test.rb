require 'test_helper'

class MembershipTest < ActiveSupport::TestCase
  test 'validates uniqueness of user and team' do
    membership = Membership.new(user: users(:diego),
                                team: teams(:campeones))
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

  test '#update_active_members callback on #accept' do
    membership = memberships(:pele_campeones_invited)
    assert_difference -> { membership.team.reload.active_members }, +1 do
      membership.accept
    end
  end

  test '#leave without accept' do
    membership = memberships(:pele_campeones_invited)

    assert_no_difference -> { membership.team.reload.active_members } do
      membership.leave
    end

    assert_raises(ActiveRecord::RecordNotFound) do
      membership.reload
    end
  end

  test '#leave after accept' do
    membership = memberships(:pele_campeones_invited)
    membership.accept

    assert_difference -> { membership.team.reload.active_members }, -1 do
      membership.leave
    end
  end
end
