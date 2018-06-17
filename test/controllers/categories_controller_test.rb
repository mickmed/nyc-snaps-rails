require 'test_helper'

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get name:string" do
    get categories_name:string_url
    assert_response :success
  end

end
