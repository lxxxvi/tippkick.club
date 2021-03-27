require 'test_helper'

class TeamPolicyTest < ActiveSupport::TestCase
  test 'coach' do
    team = teams(:campeones)
    user = users(:diego)

    TeamPolicy.new(team, user: user).tap do |policy|
      assert policy.show?
      assert policy.create?
      assert policy.destroy?
      assert policy.update?
      assert_not policy.leave?
      assert policy.invite?
    end
  end

  test 'non-coach, member' do
    team = teams(:campeones)
    user = users(:pele)

    TeamPolicy.new(team, user: user).tap do |policy|
      assert policy.show?
      assert policy.create?
      assert_not policy.destroy?
      assert_not policy.update?
      assert policy.leave?
      assert_not policy.invite?
    end
  end

  test 'cannot leave global team' do
    team = teams(:global)
    user = users(:diego)

    TeamPolicy.new(team, user: user).tap do |policy|
      assert policy.show?
      assert policy.create?
      assert_not policy.destroy?
      assert_not policy.update?
      assert_not policy.leave?
      assert_not policy.invite?
    end
  end
end
