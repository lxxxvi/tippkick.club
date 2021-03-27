require 'test_helper'

class DashboardServiceTest < ActiveSupport::TestCase
  test '#total_points' do
    assert_equal 152, DashboardService.new(users(:diego)).total_points
  end
end
