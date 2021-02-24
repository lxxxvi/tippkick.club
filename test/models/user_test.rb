require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'valid user' do
    user = User.new(email: 'pele@tippkick.test', password: 'pele')

    assert_difference -> { Prediction.count }, +51 do
      assert user.save!
    end

    assert_match /[[:alnum:]]{5}/, user.tippkick_id
    assert_match /[[:alnum:]]{5}/, user.nickname
  end

  test 'user_group association' do
    user = users(:diego)

    assert_includes user.user_groups,
                    user_groups(:campeones)
  end
end
