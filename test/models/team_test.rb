require 'test_helper'

class TeamTest < ActiveSupport::TestCase
  test 'validates uniqueness of name' do
    team = Team.new(name: 'Campeones')

    assert_not team.valid?
    assert_includes team.errors[:name],
                    'has already been taken'
  end

  test 'users association' do
    team = teams(:campeones)

    assert_includes team.users,
                    users(:diego)
  end

  test '#membership_for' do
    user = users(:diego)
    team = teams(:campeones)
    membership = memberships(:diego_campeones)

    assert_equal membership, team.membership_for(user)
  end

  test '.invite' do
    new_user = User.create!(email: 'zinedine@tippkick.test', password: 'frappe')
    team = teams(:campeones)

    assert_no_difference -> { team.reload.active_members } do
      assert_difference -> { team.memberships.invited.count }, +1 do
        team.invite(new_user)
      end
    end
  end

  test '.create_with_user' do
    user = users(:diego)

    assert_difference -> { user.memberships.count }, +1 do
      Team.create_with_user(user, 'Argentinos')
    end

    team = Team.find_by(name: 'Argentinos')

    team.memberships.tap do |memberships|
      assert_equal 1, memberships.count

      membership = memberships.first
      assert_equal user, membership.user
      assert membership.admin?
      assert membership.accepted?
    end
  end
end
