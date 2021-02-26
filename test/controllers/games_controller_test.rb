require "test_helper"

class GamesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get games_path
    assert_response :success
  end

  test "should get edit" do
    get edit_game_path
    assert_response :success
  end

  test "should post update" do
    assert false, 'todo'
    post game_path
    assert_response :success
  end
end
