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

  test 'should get delete, if admin' do
    team = teams(:campeones)
    sign_in_as :diego

    assert_difference -> { Team.count }, -1 do
      delete team_path(team)
    end

    follow_redirect!
    assert_response :success

    assert_equal 'Team deleted successfully.', flash[:notice]
  end

  test 'should NOT get delete, if NOT admin' do
    team = teams(:campeones)
    membership = memberships(:pele_campeones_invited)
    membership.accept
    assert_not membership.admin?, 'Should not be admin'

    sign_in_as :pele

    assert_raises(ActionPolicy::Unauthorized) do
      delete team_path(team)
    end
  end

  test 'should put update, if admin' do
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

  test 'should NOT put update, if NOT admin' do
    team = teams(:campeones)
    sign_in_as :pele

    assert_raises(ActionPolicy::Unauthorized) do
      put team_path(team), params: {}
    end
  end
end
