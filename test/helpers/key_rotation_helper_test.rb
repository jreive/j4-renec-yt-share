require "test_helper"

class KeyRotationHelperTest < ActiveSupport::TestCase
  test "Should return correct sample" do
    helper = KeyRotationHelper.new(['abc'])
    assert_equal helper.get_random, 'abc'
  end

  test "Should random" do
    helper = KeyRotationHelper.new(['abc', 'def', 'ghi', 'jkl', 'mno', 'pqr'])
    f_key = helper.get_random
    s_key = helper.get_random
    t_key = helper.get_random
    x_key = helper.get_random
    uniq = [f_key, s_key, t_key, x_key].uniq
    assert_equal true, uniq.length > 1
  end

end
