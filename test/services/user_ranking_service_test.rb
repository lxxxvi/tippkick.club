require 'test_helper'

class UserRankingServiceTest < ActiveSupport::TestCase
  test '.call!' do
    user = users(:diego)
    user_2 = users(:pele)
    assert_changes -> { user_2.reload.global_ranking_position }, to: 2 do
      assert_changes -> { user.reload.global_ranking_position }, to: 1 do
        UserRankingService.new.call!
      end
    end
  end
end
