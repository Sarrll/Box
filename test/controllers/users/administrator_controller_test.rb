require 'test_helper'

class Users::AdministratorControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end
  
   test "should get edit_user" do
     get :edit_user
     assert_response :success
   end

end
