require 'test_helper'

class GameBetsCountServiceTest < ActiveSupport::TestCase
  test '#call!, all' do
    reset_games_bets_count_columns
    GameBetsCountService.new.call!

    games(:game_1).tap do |game|
      assert_equal 1, game.bets_home_team_wins_count
      assert_equal 1, game.bets_guest_team_wins_count
      assert_equal 1, game.bets_draw_count
    end

    games(:game_2).tap do |game|
      assert_equal 1, game.bets_home_team_wins_count
      assert_equal 0, game.bets_guest_team_wins_count
      assert_equal 2, game.bets_draw_count
    end

    games(:game_16).tap do |game|
      assert_equal 0, game.bets_home_team_wins_count
      assert_equal 0, game.bets_guest_team_wins_count
      assert_equal 3, game.bets_draw_count
    end
  end

  test '#call!, scoped on game' do
    reset_games_bets_count_columns
    game_1 = games(:game_1)
    game_2 = games(:game_2)

    game_2.update_column(:bets_home_team_wins_count, 999)

    GameBetsCountService.new(game_1).call!

    game_1.reload

    games(:game_1).tap do |game|
      assert_equal 1, game.bets_home_team_wins_count
      assert_equal 1, game.bets_guest_team_wins_count
      assert_equal 1, game.bets_draw_count
    end

    game_2.reload

    assert_equal 999,
                 game_2.bets_home_team_wins_count,
                 'should not have change because service was scoped on game_1 only'
  end

  private

  def reset_games_bets_count_columns
    Game.update_all(
      bets_home_team_wins_count: 0,
      bets_guest_team_wins_count: 0,
      bets_draw_count: 0
    )
  end
end
