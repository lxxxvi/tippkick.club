require 'test_helper'

class BetsStatsServiceTest < ActiveSupport::TestCase
  test 'game 1, all different bets' do
    game = games(:game_1)

    BetsStatsService.new.call!

    assert_equal 3, game.bets_stats.count

    zero_zero_bet = game.bets_stats.find_by(bet_home_team_score: 0, bet_guest_team_score: 0)
    assert_equal 0, zero_zero_bet.bet_home_team_score
    assert_equal 0, zero_zero_bet.bet_guest_team_score
    assert_equal 1, zero_zero_bet.bet_count

    zero_one_bet = game.bets_stats.find_by(bet_home_team_score: 0, bet_guest_team_score: 1)
    assert_equal 0, zero_one_bet.bet_home_team_score
    assert_equal 1, zero_one_bet.bet_guest_team_score
    assert_equal 1, zero_one_bet.bet_count

    four_three_bet = game.bets_stats.find_by(bet_home_team_score: 4, bet_guest_team_score: 3)
    assert_equal 4, four_three_bet.bet_home_team_score
    assert_equal 3, four_three_bet.bet_guest_team_score
    assert_equal 1, four_three_bet.bet_count
  end

  test 'game 25, two same bets' do
    game = games(:game_25)

    BetsStatsService.new.call!

    assert_equal 2, game.bets_stats.count

    one_two_bet = game.bets_stats.find_by(bet_home_team_score: 1, bet_guest_team_score: 2)
    assert_equal 1, one_two_bet.bet_home_team_score
    assert_equal 2, one_two_bet.bet_guest_team_score
    assert_equal 2, one_two_bet.bet_count

    five_zero_bet = game.bets_stats.find_by(bet_home_team_score: 5, bet_guest_team_score: 0)
    assert_equal 5, five_zero_bet.bet_home_team_score
    assert_equal 0, five_zero_bet.bet_guest_team_score
    assert_equal 1, five_zero_bet.bet_count
  end

  test 'game 8, three same bets' do
    game = games(:game_8)

    BetsStatsService.new.call!

    assert_equal 1, game.bets_stats.count

    two_two_bet = game.bets_stats.find_by(bet_home_team_score: 2, bet_guest_team_score: 2)
    assert_equal 2, two_two_bet.bet_home_team_score
    assert_equal 2, two_two_bet.bet_guest_team_score
    assert_equal 3, two_two_bet.bet_count
  end
end
