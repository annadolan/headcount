require './test/test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/district'
require 'pry'

class DistrictTest < Minitest::Test
  def test_district_name_is_returned
    d = District.new({:name => "ACADEMY 20"})
    assert_equal "ACADEMY 20", d.name
  end
    
end
