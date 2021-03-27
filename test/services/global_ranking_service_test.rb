require 'test_helper'

class GlobalRankingServiceTest < ActiveSupport::TestCase
  test '.call!' do
    user_1, user_2, user_3 = users(:diego, :zinedine, :pele)

    assert_changes -> { user_3.reload.global_ranking_position }, to: 3 do
      assert_changes -> { user_2.reload.global_ranking_position }, to: 2 do
        assert_changes -> { user_1.reload.global_ranking_position }, to: 1 do
          GlobalRankingService.new.call!
        end
      end
    end
  end
end
