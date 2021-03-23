require 'test_helper'

class TeamPolicyTest < ActiveSupport::TestCase
  test 'admin' do
    team = teams(:campeones)
    team_admin = users(:diego)

    TeamPolicy.new(team, user: team_admin).tap do |policy|
      assert policy.show?
      assert policy.create?
      assert policy.destroy?
      assert policy.update?
    end
  end

  test 'non-admin' do
    team = teams(:campeones)
    team_admin = users(:pele)

    TeamPolicy.new(team, user: team_admin).tap do |policy|
      assert policy.show?
      assert policy.create?
      assert_not policy.destroy?
      assert_not policy.update?
    end
  end
end
