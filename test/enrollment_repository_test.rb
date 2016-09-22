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
        :kindergarten => "./data/Kindergartners in full-day program.csv"
      }
    })
    assert_instance_of Hash, er.enrollments
  end

  def test_find_by_name_returns_new_enrollment_instance
    er = EnrollmentRepository.new
    er.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv"
      }
    })
    assert_instance_of Enrollment, er.find_by_name("ADAMS COUNTY 14")
  end

  def test_find_by_name_can_use_lowercase
    er = EnrollmentRepository.new
    er.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv"
      }
    })
    assert_instance_of Enrollment, er.find_by_name("adams county 14")
  end

  def test_find_by_name_returns_enrollment_instance_with_correct_name
    er = EnrollmentRepository.new
    er.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv"
      }
    })
    assert_equal "ADAMS COUNTY 14", er.find_by_name("ADAMS COUNTY 14").name
  end

  def test_find_by_name_returns_enrollment_instance_with_correct_data
    er = EnrollmentRepository.new
    er.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv"
      }
    })
    assert_equal [2014, 1.0], er.find_by_name("ADAMS COUNTY 14").information[:kindergarten_participation].to_a.last
  end

  def test_find_by_name_returns_nil_if_no_matching
    er = EnrollmentRepository.new
    er.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv"
      }
    })
    assert_equal nil, er.find_by_name("XYZ")
  end

  def test_kindergarten_participation_in_year
    er = EnrollmentRepository.new
    er.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv"
      }
    })
    name = "GUNNISON WATERSHED RE1J"
    enrollment = er.find_by_name(name)
    assert_equal name, enrollment.name
    assert enrollment.is_a?(Enrollment)
    assert_in_delta 0.144, enrollment.kindergarten_participation_in_year(2004), 0.005
  end

  def test_er_can_load_a_second_file
    er = EnrollmentRepository.new
    er.load_data({
                   :enrollment => {
                     :kindergarten => "./data/Kindergartners in full-day program.csv",
                     :high_school_graduation => "./data/High school graduation rates.csv"
                   }
                 })
    result = er.find_by_name("ACADEMY 20")
    assert_equal 0.895, result.information[:high_school_graduation][2010]
  end
end
