require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'valid user' do
    user = User.new(email: 'zinedine@tippkick.test', password: 'zinedine')

    assert_difference -> { Prediction.count }, +51 do
      assert user.save!
    end

    assert_match /[[:alnum:]]{5}/, user.tippkick_id
    assert_match /[[:alnum:]]{5}/, user.nickname
  end

  test 'team association' do
    user = users(:diego)

    assert_includes user.teams,
                    teams(:campeones)
  end

  test '#membership_for' do
    user = users(:diego)
    team = teams(:campeones)
    membership = memberships(:diego_campeones)

    assert_equal membership, user.membership_for(team)
  end
end
