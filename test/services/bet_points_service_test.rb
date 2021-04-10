require 'test_helper'

class BetPointsServiceTest < ActiveSupport::TestCase
  test '.call! focus on Bet' do
    perfect_bet = bets(:diego_game_1) # P 4:3 | A 4:3
    draw_bet = bets(:diego_game_2) # P 0:0 | A 1:1
    home_wins_bet = bets(:diego_game_13) # P 1:0 | A 2:0
    guest_wins_bet = bets(:diego_game_14) # P 0:1 | A 0:2
    failed_bet = bets(:diego_game_3) # P 0:2 | A 2:1
    wrong_bet = bets(:diego_game_4) # P 1:0 | A 1:2

    assert_nil perfect_bet.home_team_score_points
    assert_nil perfect_bet.guest_team_score_points
    assert_nil perfect_bet.result_points
    assert_nil perfect_bet.perfect_bet_bonus_points

    assert_nil draw_bet.home_team_score_points
    assert_nil draw_bet.guest_team_score_points
    assert_nil draw_bet.result_points
    assert_nil draw_bet.perfect_bet_bonus_points

    assert_nil home_wins_bet.home_team_score_points
    assert_nil home_wins_bet.guest_team_score_points
    assert_nil home_wins_bet.result_points
    assert_nil home_wins_bet.perfect_bet_bonus_points

    assert_nil guest_wins_bet.home_team_score_points
    assert_nil guest_wins_bet.guest_team_score_points
    assert_nil guest_wins_bet.result_points
    assert_nil guest_wins_bet.perfect_bet_bonus_points

    assert_nil failed_bet.home_team_score_points
    assert_nil failed_bet.guest_team_score_points
    assert_nil failed_bet.result_points
    assert_nil failed_bet.perfect_bet_bonus_points

    assert_nil wrong_bet.home_team_score_points
    assert_nil wrong_bet.guest_team_score_points
    assert_nil wrong_bet.result_points
    assert_nil wrong_bet.perfect_bet_bonus_points

    BetPointsService.new.call!

    assert_equal 12, perfect_bet.reload.total_points
    assert_equal 4, perfect_bet.home_team_score_points
    assert_equal 3, perfect_bet.guest_team_score_points
    assert_equal 3, perfect_bet.result_points
    assert_equal 2, perfect_bet.perfect_bet_bonus_points

    assert_equal 3, draw_bet.reload.total_points
    assert_equal 0, draw_bet.home_team_score_points
    assert_equal 0, draw_bet.guest_team_score_points
    assert_equal 3, draw_bet.result_points
    assert_equal 0, draw_bet.perfect_bet_bonus_points

    assert_equal 3, home_wins_bet.reload.total_points
    assert_equal 0, home_wins_bet.home_team_score_points
    assert_equal 0, home_wins_bet.guest_team_score_points
    assert_equal 3, home_wins_bet.result_points
    assert_equal 0, home_wins_bet.perfect_bet_bonus_points

    assert_equal 3, guest_wins_bet.reload.total_points
    assert_equal 0, guest_wins_bet.home_team_score_points
    assert_equal 0, guest_wins_bet.guest_team_score_points
    assert_equal 3, guest_wins_bet.result_points
    assert_equal 0, guest_wins_bet.perfect_bet_bonus_points

    assert_equal 0, failed_bet.reload.total_points
    assert_equal 0, failed_bet.home_team_score_points
    assert_equal 0, failed_bet.guest_team_score_points
    assert_equal 0, failed_bet.result_points
    assert_equal 0, failed_bet.perfect_bet_bonus_points

    assert_equal 1, wrong_bet.reload.total_points
    assert_equal 1, wrong_bet.home_team_score_points
    assert_equal 0, wrong_bet.guest_team_score_points
    assert_equal 0, wrong_bet.result_points
    assert_equal 0, wrong_bet.perfect_bet_bonus_points
  end

  test '.call! focus on User.total_points' do
    user = users(:diego)
    user.update_column(:total_points, 0)

    assert_changes -> { user.reload.total_points }, to: 152 do
      BetPointsService.new.call!
    end
  end

  test '.call! focus on Game.max_total_points' do
    game = games(:game_1)
    game.update_column(:max_total_points, nil)

    assert_changes -> { game.reload.max_total_points }, to: 12 do
      BetPointsService.new.call!
    end
  end

  test '0 points for no bet games' do
    new_user = User.create!(email: 'messi@tippkick.test', password: 'messi')

    BetPointsService.new.call!
    assert_equal 0, new_user.reload.total_points
  end
end
