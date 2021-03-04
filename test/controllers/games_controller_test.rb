require 'test_helper'

class GamesControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get games_path
    assert_response :success
    assert_select '.game-card', count: 27
  end

  test 'should get index with filter: :past' do
    get games_path(filter: :past)
    assert_response :success
    assert_select '.game-card', count: 24
  end
end
