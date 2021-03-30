require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'valid user' do
    user = User.new(email: 'messi@tippkick.test', password: 'messi', rooting_for_team: 'ESP')

    assert_difference -> { Prediction.count }, +51 do
      assert user.save!
    end

    assert_match /[[:alnum:]]{5}/, user.tippkick_id
    assert_match /[[:alnum:]]{5}/, user.nickname

    assert_equal 1, user.teams.count
    assert_equal teams(:global), user.teams.first
  end

  test 'team association' do
    user = users(:diego)

    assert_includes user.teams,
                    teams(:campeones)
  end

  test 'validates rooting_for_team' do
    user = users(:diego)

    assert_not user.update(rooting_for_team: 'ARG')
    assert_includes user.errors[:rooting_for_team], 'is not included in the list'

    assert user.update(rooting_for_team: '')
  end

  test '#membership_for' do
    user = users(:diego)
    team = teams(:campeones)
    membership = memberships(:diego_campeones)

    assert_equal membership, user.membership_for(team)
  end
end
