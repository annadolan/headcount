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
    assert_instance_of Hash, er.organized_entries
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
    assert_equal ({:location=>"ADAMS COUNTY 14", :timeframe=>"2014", :dataformat=>"Percent", :data=>"1"}), er.find_by_name("ADAMS COUNTY 14").enrollment_data.last
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
end
