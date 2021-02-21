require 'test_helper'

class PredictionTest < ActiveSupport::TestCase
  test 'valid prediction' do
    prediction = Prediction.new(user: users(:diego),
                                game: games(:game_1))

    assert prediction.save!
  end
end
