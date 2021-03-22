require 'test_helper'

class TeamPolicyTest < ActiveSupport::TestCase
  test '#destroy with admin' do
    team = teams(:campeones)
    team_admin = users(:diego)

    TeamPolicy.new(team, user: team_admin).tap do |policy|
      assert policy.destroy?
    end
  end

  test '#destroy with non-admin' do
    team = teams(:campeones)
    team_admin = users(:pele)

    TeamPolicy.new(team, user: team_admin).tap do |policy|
      assert_not policy.destroy?
    end
  end
end
