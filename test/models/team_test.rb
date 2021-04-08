require 'test_helper'

class TeamTest < ActiveSupport::TestCase
  test 'validates uniqueness of name' do
    team = Team.new(name: 'Campeones')

    assert_not team.valid?
    assert_includes team.errors[:name], 'has already been taken'
  end

  test 'users association' do
    team = teams(:campeones)

    assert_includes team.users, users(:diego)
  end

  test 'save' do
    team = Team.new(name: 'Argentinos')
    assert team.save

    assert_match /[[:alnum:]]{5}/, team.tippkick_id
    assert_match /[[:alnum:]]{10}/, team.invitation_token
  end

  test '#membership_for' do
    user = users(:diego)
    team = teams(:campeones)
    membership = memberships(:diego_campeones)

    assert_equal membership, team.membership_for(user)
  end

  test '.new_with_user' do
    user = users(:diego)

    team = Team.new_with_user(user, name: 'Argentinos')
    team.save!

    team.memberships.tap do |memberships|
      assert_equal 1, memberships.count

      membership = memberships.first
      assert_equal user, membership.user
      assert membership.coach?
    end
  end

  test '#refresh_invitation_token!' do
    team = teams(:campeones)
    assert_changes -> { team.reload.invitation_token } do
      team.refresh_invitation_token!
    end
  end
end
