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
    assert_instance_of Hash, dr.organized_entries
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
    dr.find_all_matching("we")
    assert_equal 7, dr.district.count
  end

  def test_find_all_matching_returns_array
    dr = DistrictRepository.new
    dr.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv"
      }
    })
    dr.find_all_matching("we")
    assert_instance_of Array, dr.district
  end

  def test_find_all_matching_returns_empty_array_if_no_matching
    dr = DistrictRepository.new
    dr.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv"
      }
    })
    dr.find_all_matching("xyzz")
    assert_equal [], dr.district
  end

  def test_find_all_matching_array_contains_hashes
    dr = DistrictRepository.new
    dr.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv"
      }
    })
    dr.find_all_matching("we")
    assert_instance_of Hash, dr.district[0]
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
  end
end
