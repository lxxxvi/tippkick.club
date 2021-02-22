require 'test_helper'

class GameTest < ActiveSupport::TestCase
  test '51 games' do
    assert_equal 1, Game.final_phase.count
    assert_equal 2, Game.semi_finals_phase.count
    assert_equal 4, Game.quarter_finals_phase.count
    assert_equal 8, Game.round_of_16_phase.count
    assert_equal 36, Game.group_phase.count
    assert_equal 51, Game.count
  end
end
