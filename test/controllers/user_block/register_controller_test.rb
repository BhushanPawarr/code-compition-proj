require "test_helper"

class UserBlock::RegisterControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get user_block_register_create_url
    assert_response :success
  end

  test "should get show" do
    get user_block_register_show_url
    assert_response :success
  end
end
