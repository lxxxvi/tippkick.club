require 'test_helper'

class UserPolicyTest < ActiveSupport::TestCase
  test 'admin' do
    user = users(:diego)
    user.update(admin: true)

    UserPolicy.new(user, user: user).tap do |policy|
      assert policy.admin?
    end
  end
end
