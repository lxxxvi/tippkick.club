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
  end
end
