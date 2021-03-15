require 'test_helper'

class PredictionPointsServiceTest < ActiveSupport::TestCase
  test '.call!' do
    perfect_prediction = predictions(:diego_game_1) # P 4:3 | A 4:3
    draw_prediction = predictions(:diego_game_2) # P 0:0 | A 1:1
    home_wins_prediction = predictions(:diego_game_13) # P 1:0 | A 2:0
    guest_wins_prediction = predictions(:diego_game_14) # P 0:1 | A 0:2
    failed_prediction = predictions(:diego_game_3) # P 0:2 | A 2:1
    wrong_prediction = predictions(:diego_game_4) # P 1:0 | A 1:2

    assert_nil perfect_prediction.home_team_score_points
    assert_nil perfect_prediction.guest_team_score_points
    assert_nil perfect_prediction.result_points
    assert_nil perfect_prediction.perfect_prediction_bonus_points

    assert_nil draw_prediction.home_team_score_points
    assert_nil draw_prediction.guest_team_score_points
    assert_nil draw_prediction.result_points
    assert_nil draw_prediction.perfect_prediction_bonus_points

    assert_nil home_wins_prediction.home_team_score_points
    assert_nil home_wins_prediction.guest_team_score_points
    assert_nil home_wins_prediction.result_points
    assert_nil home_wins_prediction.perfect_prediction_bonus_points

    assert_nil guest_wins_prediction.home_team_score_points
    assert_nil guest_wins_prediction.guest_team_score_points
    assert_nil guest_wins_prediction.result_points
    assert_nil guest_wins_prediction.perfect_prediction_bonus_points

    assert_nil failed_prediction.home_team_score_points
    assert_nil failed_prediction.guest_team_score_points
    assert_nil failed_prediction.result_points
    assert_nil failed_prediction.perfect_prediction_bonus_points

    assert_nil wrong_prediction.home_team_score_points
    assert_nil wrong_prediction.guest_team_score_points
    assert_nil wrong_prediction.result_points
    assert_nil wrong_prediction.perfect_prediction_bonus_points

    PredictionPointsService.new.call!

    assert_equal 12, perfect_prediction.reload.total_points
    assert_equal 4, perfect_prediction.home_team_score_points
    assert_equal 3, perfect_prediction.guest_team_score_points
    assert_equal 3, perfect_prediction.result_points
    assert_equal 2, perfect_prediction.perfect_prediction_bonus_points

    assert_equal 3, draw_prediction.reload.total_points
    assert_equal 0, draw_prediction.home_team_score_points
    assert_equal 0, draw_prediction.guest_team_score_points
    assert_equal 3, draw_prediction.result_points
    assert_equal 0, draw_prediction.perfect_prediction_bonus_points

    assert_equal 3, home_wins_prediction.reload.total_points
    assert_equal 0, home_wins_prediction.home_team_score_points
    assert_equal 0, home_wins_prediction.guest_team_score_points
    assert_equal 3, home_wins_prediction.result_points
    assert_equal 0, home_wins_prediction.perfect_prediction_bonus_points

    assert_equal 3, guest_wins_prediction.reload.total_points
    assert_equal 0, guest_wins_prediction.home_team_score_points
    assert_equal 0, guest_wins_prediction.guest_team_score_points
    assert_equal 3, guest_wins_prediction.result_points
    assert_equal 0, guest_wins_prediction.perfect_prediction_bonus_points

    assert_equal 0, failed_prediction.reload.total_points
    assert_equal 0, failed_prediction.home_team_score_points
    assert_equal 0, failed_prediction.guest_team_score_points
    assert_equal 0, failed_prediction.result_points
    assert_equal 0, failed_prediction.perfect_prediction_bonus_points

    assert_equal 1, wrong_prediction.reload.total_points
    assert_equal 1, wrong_prediction.home_team_score_points
    assert_equal 0, wrong_prediction.guest_team_score_points
    assert_equal 0, wrong_prediction.result_points
    assert_equal 0, wrong_prediction.perfect_prediction_bonus_points

    assert_equal 152, users(:diego).total_points
  end

  test '0 points for no predicted games' do
    new_user = User.create!(email: 'zinedine@tippkick.test', password: 'frappe')

    assert_changes -> { new_user.reload.total_points }, to: 0 do
      PredictionPointsService.new.call!
    end
  end
end
