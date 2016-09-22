require './test/test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/result_set'
require './lib/district_repository'
require 'pry'

class ResultSetTest < Minitest::Test
  
  def test_result_set_has_a_matching_district_method_that_is_an_array_of_objects
    rs = ResultSet.new
    assert_instance_of ResultEntry, rs.matching_districts[3]
    assert_instance_of Array, rs.matching_districts
  end
  
  
end