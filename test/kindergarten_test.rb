require './test/test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/kindergarten'
require 'pry'

class KindergartenTest < Minitest::Test
  
  include Kindergarten
  
  def test_truncate_float_truncates_float
    assert_equal 0.123, truncate_float(0.1232903871209389038219038109381290388)
  end
  
  def test_truncate_float_returns_nil_if_given_zeroes
    assert_equal nil, truncate_float(0)
  end
  
end