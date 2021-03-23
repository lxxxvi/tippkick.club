require 'test_helper'

class TeamPolicyTest < ActiveSupport::TestCase
  test 'coach' do
    team = teams(:campeones)
    team_coach = users(:diego)

    TeamPolicy.new(team, user: team_coach).tap do |policy|
      assert policy.show?
      assert policy.create?
      assert policy.destroy?
      assert policy.update?
    end
  end

  test 'non-coach' do
    team = teams(:campeones)
    team_coach = users(:pele)

    TeamPolicy.new(team, user: team_coach).tap do |policy|
      assert policy.show?
      assert policy.create?
      assert_not policy.destroy?
      assert_not policy.update?
    end
  end
end
