require 'test_helper'

class GrowthCurveSampleControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get growth_curve_sample_index_url
    assert_response :success
  end

end
