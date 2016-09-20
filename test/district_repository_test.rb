require './test/test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/district_repository'
require './lib/district'
require 'pry'

class DistrictRepositoryTest < Minitest::Test

  include Kindergarten

  def test_dr_loads_data_into_hash
    dr = DistrictRepository.new
    dr.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv"
      }
    })
    assert_instance_of Hash, dr.districts
  end

  def test_find_by_name_returns_new_district_instance
    dr = DistrictRepository.new
    dr.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv"
      }
    })
    assert_instance_of District, dr.find_by_name("ADAMS COUNTY 14")
  end

  def test_find_by_name_can_use_lowercase
    dr = DistrictRepository.new
    dr.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv"
      }
    })
    assert_instance_of District, dr.find_by_name("adams county 14")
  end

  def test_find_by_name_returns_nil_if_no_matching
    dr = DistrictRepository.new
    dr.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv"
      }
    })
    assert_equal nil, dr.find_by_name("QWX")
  end

  def test_dr_can_find_using_just_a_fragment
    dr = DistrictRepository.new
    dr.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv"
      }
    })
    assert_equal 7, dr.find_all_matching("we").count
  end

  def test_find_all_matching_returns_array
    dr = DistrictRepository.new
    dr.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv"
      }
    })
    assert_instance_of Array, dr.find_all_matching("we")
  end

  def test_find_all_matching_returns_empty_array_if_no_matching
    dr = DistrictRepository.new
    dr.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv"
      }
    })
    assert_equal [], dr.find_all_matching("xyzz")
  end

  def test_dr_can_return_kindergarten_participation_in_year
    dr = DistrictRepository.new
    dr.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv"
      }
    })
    district = dr.find_by_name("ACADEMY 20")
    assert_in_delta 0.436, district.enrollment.kindergarten_participation_in_year(2010), 0.005

    district = dr.find_by_name("GUNNISON WATERSHED RE1J")
    assert_in_delta 0.144, district.enrollment.kindergarten_participation_in_year(2004), 0.005
    assert_equal 0.144, district.enrollment.kindergarten_participation_in_year(2004)
  end
  
  def test_dr_can_connect_districts_with_statewide_test
    dr = DistrictRepository.new
    dr.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv",
        :high_school_graduation => "./data/High school graduation rates.csv",
      },
      :statewide_testing => {
        :third_grade => "./data/3rd grade students scoring proficient or above on the CSAP_TCAP.csv",
        :eighth_grade => "./data/8th grade students scoring proficient or above on the CSAP_TCAP.csv",
        :math => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Math.csv",
        :reading => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Reading.csv",
        :writing => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Writing.csv"
      }
      })
      district = dr.find_by_name("ACADEMY 20")
      assert_instance_of StatewideTest, district.statewide_test
  end
end
