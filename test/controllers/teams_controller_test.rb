require 'test_helper'

class TeamsControllerTest < ActionDispatch::IntegrationTest
  test 'should get show' do
    sign_in_as :diego
    team = teams(:campeones)
    get team_path(team)
    assert_response :success
  end

  test 'should get new' do
    sign_in_as :diego
    get new_team_path
    assert_response :success
  end

  test 'should post create' do
    sign_in_as :diego

    assert_difference -> { Team.count }, +1 do
      assert_difference -> { Membership.count }, +1 do
        post teams_path, params: {
          team: {
            name: 'Argentinos'
          }
        }
      end
    end

    follow_redirect!
    assert_response :success
    assert_equal 'Team created successfully.', flash[:notice]
  end

  test 'should not post create' do
    sign_in_as :diego

    assert_no_difference -> { Team.count } do
      assert_no_difference -> { Membership.count } do
        post teams_path, params: {
          team: {
            name: 'Campeones'
          }
        }
      end
    end

    assert_response :success
    assert_equal 'Could not create team.', flash[:alert]
  end

  test 'should get delete, if coach' do
    team = teams(:campeones)
    sign_in_as :diego

    assert_difference -> { Team.count }, -1 do
      delete team_path(team)
    end

    follow_redirect!
    assert_response :success

    assert_equal 'Team deleted successfully.', flash[:notice]
  end

  test 'should NOT get delete, if NOT coach' do
    team = teams(:campeones)
    membership = memberships(:pele_campeones)
    assert_not membership.coach?, 'Should not be coach'

    sign_in_as :pele

    assert_raises(ActionPolicy::Unauthorized) do
      delete team_path(team)
    end
  end

  test 'should put update, if coach' do
    team = teams(:campeones)
    sign_in_as :diego

    assert_changes -> { team.reload.name }, to: 'The Champions' do
      put team_path(team), params: {
        team: {
          name: 'The Champions'
        }
      }
    end

    follow_redirect!
    assert_response :success

    assert_equal 'Team updated successfully.', flash[:notice]
  end

  test 'should NOT put update, if NOT coach' do
    team = teams(:campeones)
    sign_in_as :pele

    assert_raises(ActionPolicy::Unauthorized) do
      put team_path(team), params: {}
    end
  end

  test 'member should get leave' do
    team = teams(:campeones)
    sign_in_as :pele

    assert_difference -> { Membership.count }, -1 do
      get leave_team_path(team)
    end

    follow_redirect!
    assert_response :success
    assert_equal 'You left the team.', flash[:notice]
  end

  test 'member cannot leave global team' do
    team = teams(:global)
    sign_in_as :diego

    assert_raises(ActionPolicy::Unauthorized) do
      get leave_team_path(team)
    end
  end

  test 'coach should not get leave' do
    team = teams(:campeones)
    sign_in_as :diego

    assert_raises(ActionPolicy::Unauthorized) do
      get leave_team_path(team)
    end
  end

  test 'guest should get join, right token' do
    memberships(:pele_campeones).destroy
    team = teams(:campeones)
    user = users(:pele)

    sign_in_as :pele

    assert_difference -> { Membership.count }, +1 do
      get join_team_url(id: 'tkid_campeones-campeones', token: 'campeones_token')
    end

    team.membership_for(user).tap do |membership|
      assert_equal 2, membership.ranking_position
    end

    follow_redirect!
    assert_response :success

    assert_equal 'Joined team successfully.', flash[:notice]
  end

  test 'guest should NOT get join, wrong token' do
    memberships(:pele_campeones).destroy
    team = teams(:campeones)

    sign_in_as :pele

    assert_no_difference -> { Membership.count } do
      get join_team_url(team, 'wrong_token')
    end

    follow_redirect!
    assert_response :success

    assert_equal 'Could not join team, invalid token.', flash[:alert]
  end

  test 'member get join, nothing happens' do
    sign_in_as :pele

    assert_no_difference -> { Membership.count } do
      get join_team_url(id: 'tkid_campeones-campeones', token: 'campeones_token')
    end

    follow_redirect!
    assert_response :success

    assert_empty flash
  end
end
