require './test/test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './test/test_helper'
require './lib/shared_methods'
require 'pry'

class SharedMethodsTest < Minitest::Test
  include SharedMethods

  def test_loader_can_load_CSV_files
    assert_instance_of Array, load_csv('./data/Kindergartners in full-day program.csv', :kindergarten_participation)
  end
  
  def test_truncate_float_truncates_float
    assert_equal 0.123, truncate_float(0.1232903871209389038219038109381290388)
  end
  
  def test_truncate_float_returns_nil_if_given_zeroes
    assert_equal nil, truncate_float(0)
  end
  

end
