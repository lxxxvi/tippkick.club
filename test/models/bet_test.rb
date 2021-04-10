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
end
