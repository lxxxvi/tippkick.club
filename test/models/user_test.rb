require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'valid user' do
    user = User.new(email: 'pele@tippkick.test', password: 'pele')

    assert_difference -> { Prediction.count }, +51 do
      assert user.save!
    end
  end
end
