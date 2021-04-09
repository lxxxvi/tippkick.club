require 'test_helper'

class Admin::GamesControllerTest < ActionDispatch::IntegrationTest
  test 'admin should get index' do
    sign_in_as_admin :diego
    get admin_games_path
    assert_response :success
  end

  test 'non-admin should not get index' do
    sign_in_as :diego
    assert_raises(ActionPolicy::Unauthorized) { get admin_games_path }
  end

  test 'admin should get edit' do
    sign_in_as_admin :diego
    get edit_admin_game_path(games(:game_1))
    assert_response :success
  end

  test 'admin should post update' do
    sign_in_as_admin :diego

    game = games(:game_25)

    in_game_25 do
      put admin_game_path(game), params: {
        game: {
          uefa_game_id: 'x',
          venue: 'x',
          tournament_phase: 'x',
          kickoff_at: 'x',
          home_team_name: 'AUT',
          guest_team_name: 'BEL',
          home_team_score: '5',
          guest_team_score: '6',
          final_whistle_at: '1'
        }
      }

      follow_redirect!
      assert_response :success
      assert_equal 'Game successfully updated.', flash[:notice]

      game.reload

      assert_equal '25', game.uefa_game_id, 'should not have changed after POST'
      assert_equal 'baku', game.venue, 'should not have changed after POST'
      assert_equal 'group', game.tournament_phase, 'should not have changed after POST'
      assert_equal '2021-06-20 16:00:00', game.kickoff_at.to_s(:db), 'should not have changed after POST'

      assert_equal 'AUT', game.home_team_name
      assert_equal 'BEL', game.guest_team_name
      assert_equal 5, game.home_team_score
      assert_equal 6, game.guest_team_score
      assert_not_nil game.final_whistle_at
    end
  end
end
