require 'test_helper'

class PredictionTest < ActiveSupport::TestCase
  test 'validates uniqueness of game and user' do
    prediction = Prediction.new(user: users(:diego),
                                game: games(:game_1))

    assert_not prediction.save

    assert_includes prediction.errors[:game_id], 'has already been taken'
  end
end
