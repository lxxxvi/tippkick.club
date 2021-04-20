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

  test '#ordered_by_global_and_team_name' do
    user = users(:diego)

    Team.new_with_user(user, name: 'Alphas').save!
    Team.new_with_user(user, name: 'Zulus').save!

    memberships = user.memberships.with_teams.ordered_by_global_and_team_name

    assert_equal 'Global', memberships.first.team.name
    assert_equal 'Alphas', memberships.second.team.name
    assert_equal 'Zulus', memberships.last.team.name
  end
end
