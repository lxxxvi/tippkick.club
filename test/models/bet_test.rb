require 'test_helper'

class PredictionTest < ActiveSupport::TestCase
  test 'validates uniqueness of game and user' do
    prediction = Prediction.new(user: users(:diego),
                                game: games(:game_1))

    assert_not prediction.save

    assert_includes prediction.errors[:game_id], 'has already been taken'
  end

  test 'validate scores_cannot_change_after_kickoff' do
    prediction = predictions(:diego_game_25)

    before_game_25 do
      assert prediction.update(home_team_score: 9, guest_team_score: 9)
    end

    at_kickoff_of_game_25 do
      assert_not prediction.update(home_team_score: 8, guest_team_score: 8)

      assert_includes prediction.errors[:home_team_score], 'cannot be changed after kickoff'
      assert_includes prediction.errors[:guest_team_score], 'cannot be changed after kickoff'
    end
  end

  test '#predicted?' do
    prediction = predictions(:diego_game_1)

    assert_changes -> { prediction.reload.predicted? }, from: true do
      reset_prediction(prediction)
    end
  end

  test '#kickoff_future?' do
    prediction = predictions(:diego_game_25)

    before_game_25 do
      assert prediction.kickoff_future?
    end

    at_kickoff_of_game_25 do
      assert_not prediction.kickoff_future?
    end
  end
end