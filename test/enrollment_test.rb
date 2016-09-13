require 'minitest/autorun'
require 'minitest/pride'
require './lib/enrollment'
require 'pry'

class EnrollmentTest < Minitest::Test
  
  
  def test_enrollment_has_a_district_name
    er = Enrollment.new({:name => "ACADEMY 20"})
    assert_equal "ACADEMY 20", er.name
  end
  
  def test_enrollment_can_find_enrollment_data
    er = Enrollment.new({:name => "ACADEMY 20", :kindergarten_participation => {2010 => 0.3915, 2011 => 0.35356, 2012 => 0.2677}})
    assert_equal "{2010 => 0.3915, 2011 => 0.35356, 2012 => 0.2677}", er.enrollment_data
  end
  
end