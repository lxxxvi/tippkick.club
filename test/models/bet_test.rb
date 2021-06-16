require 'test_helper'

class BetTest < ActiveSupport::TestCase
  test 'validates uniqueness of game and user' do
    bet = Bet.new(user: users(:diego),
                  game: games(:game_1))

    assert_not bet.save

    assert_includes bet.errors[:game_id], 'has already been taken'
  end

  test 'validate scores_cannot_change_after_kickoff' do
    bet = bets(:diego_game_25)

    before_game_25 do
      assert bet.update(home_team_score: 9, guest_team_score: 9)
    end

    at_kickoff_of_game_25 do
      assert_not bet.update(home_team_score: 8, guest_team_score: 8)

      assert_includes bet.errors[:home_team_score], 'cannot be changed after kickoff'
      assert_includes bet.errors[:guest_team_score], 'cannot be changed after kickoff'
    end
  end

  test '#bet_complete?' do
    bet = bets(:diego_game_1)

    assert_changes -> { bet.reload.bet_complete? }, from: true do
      reset_bet(bet)
    end
  end

  test '#kickoff_future?' do
    bet = bets(:diego_game_25)

    before_game_25 do
      assert bet.kickoff_future?
    end

    at_kickoff_of_game_25 do
      assert_not bet.kickoff_future?
    end
  end

  test '.of_ended_games' do
    user = users(:diego)
    before_game_25 do
      assert_difference -> { Bet.of_user(user).of_ended_games.count }, -1 do
        games(:game_24).final_whistle(reset: true)
      end
    end
  end

  test '#update_game_bets_count after save' do
    game = games(:game_25)
    bet = bets(:diego_game_25) # bets 1:2

    before_game_25 do
      bet.update(home_team_score: 0, guest_team_score: 0)

      game.reload
      assert_equal 1, game.bets_home_team_wins_count
      assert_equal 1, game.bets_guest_team_wins_count
      assert_equal 1, game.bets_draw_count

      bet.update(home_team_score: 2, guest_team_score: 0)

      game.reload
      assert_equal 2, game.bets_home_team_wins_count
      assert_equal 1, game.bets_guest_team_wins_count
      assert_equal 0, game.bets_draw_count

      bet.update(home_team_score: 0, guest_team_score: 2)

      game.reload
      assert_equal 1, game.bets_home_team_wins_count
      assert_equal 2, game.bets_guest_team_wins_count
      assert_equal 0, game.bets_draw_count
    end
  end
end
