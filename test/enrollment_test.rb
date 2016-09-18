require './test/test_helper'
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
    assert_equal ({2010=>0.3915, 2011=>0.35356, 2012=>0.2677}), er.information[:kindergarten_participation]
  end

  def test_kindergarten_participaton_by_year_returns_empty_hash_with_nil_input
    er = Enrollment.new({:name => "ACADEMY 20", :kindergarten_participation => {}})
    assert_equal ({}), er.information[:kindergarten_participation]
  end

  def test_kindergarten_participation_by_year_returns_hash_of_correct_length
    er = Enrollment.new({:name => "ACADEMY 20", :kindergarten_participation => {2010 => 0.3915, 2011 => 0.35356, 2012 => 0.2677}})
    assert_instance_of Hash, er.kindergarten_participation_by_year
  end

  def test_kindergarten_participation_in_year_returns_float
    er = Enrollment.new({:name => "ACADEMY 20", :kindergarten_participation => {2010 => 0.3915, 2011 => 0.35356, 2012 => 0.2677}})
    assert_instance_of Hash, er.information
    assert_instance_of Float, er.kindergarten_participation_in_year(2012)
  end

  def test_kindergarten_participation_in_year_returns_correct_float
    er = Enrollment.new({:name => "ACADEMY 20", :kindergarten_participation => {2010 => 0.3915, 2011 => 0.35356, 2012 => 0.2677}})
    assert_equal 0.2677, er.kindergarten_participation_in_year(2012)
  end

end
