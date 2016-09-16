require './test/test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/enrollment_repository'
require './lib/enrollment'
require 'pry'

class EnrollmentRepositoryTest < Minitest::Test
  def test_er_loads_data_into_hash
    er = EnrollmentRepository.new
    er.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv",
        :high_school_graduation => "./data/High school graduation rates.csv"
      }
    })
    assert_instance_of Hash, er.organized_entries_hs
  end

  def test_populate_can_populate_enrollments_with_two_new_enrollment_objects
    er = EnrollmentRepository.new
    er.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv",
        :high_school_graduation => "./data/High school graduation rates.csv"
      }
    })
  
    assert_instance_of Enrollment, er.enrollment_hs
    assert_instance_of Enrollment, er.enrollment_kg
  end


  def test_find_by_name_returns_new_enrollment_instance
    skip
    er = EnrollmentRepository.new
    er.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv",
        :high_school_graduation => "./data/High school graduation rates.csv"
      }
    })
    assert_instance_of Enrollment, er.find_by_name("ADAMS COUNTY 14")
  end

  def test_find_by_name_can_use_lowercase
    skip
    er = EnrollmentRepository.new
    er.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv",
        :high_school_graduation => "./data/High school graduation rates.csv"
      }
    })
    assert_instance_of Enrollment, er.find_by_name("adams county 14")
  end

  def test_find_by_name_returns_enrollment_instance_with_correct_name
    skip
    er = EnrollmentRepository.new
    er.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv",
        :high_school_graduation => "./data/High school graduation rates.csv"
      }
    })
    assert_equal "ADAMS COUNTY 14", er.find_by_name("ADAMS COUNTY 14").name
  end

  def test_find_by_name_returns_enrollment_instance_with_correct_data
    skip
    er = EnrollmentRepository.new
    er.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv",
        :high_school_graduation => "./data/High school graduation rates.csv"
      }
    })
    assert_equal [2014, 1.0], er.find_by_name("ADAMS COUNTY 14").enrollment.to_a.last
  end

  def test_find_by_name_returns_nil_if_no_matching
    skip
    er = EnrollmentRepository.new
    er.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv",
        :high_school_graduation => "./data/High school graduation rates.csv"
      }
    })
    assert_equal nil, er.find_by_name("XYZ")
  end

  def test_kindergarten_participation_in_year
    skip
    er = EnrollmentRepository.new
    er.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv",
        :high_school_graduation => "./data/High school graduation rates.csv"
      }
    })
    name = "GUNNISON WATERSHED RE1J"
    enrollment = er.find_by_name(name)
    assert_equal name, enrollment_kg.name
    assert enrollment.is_a?(Enrollment)
    assert_in_delta 0.144, enrollment.kindergarten_participation_in_year(2004), 0.005
  end


end
