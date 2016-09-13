require 'minitest/autorun'
require 'minitest/pride'
require './lib/district_repository'
require 'pry'

class DistrictRepositoryTest < Minitest::Test

  def test_dr_can_load_a_csv
    dr = DistrictRepository.new
    dr.load_data
    assert_instance_of Hash, dr.data_hash
  end

  def test_dr_can_find_a_district_by_name
    dr = DistrictRepository.new
    dr.load_data
    dr.find_by_name("ACADEMY 20")
    assert_equal "0.49022", dr.district["data"]
  end

  def test_dr_can_find_using_just_a_fragment
    dr = DistrictRepository.new
    dr.load_data
    dr.find_all_matching("we")
    assert_equal 7, dr.district.count
  end

  def test_find_all_matching_returns_array
    dr = DistrictRepository.new
    dr.load_data
    dr.find_all_matching("we")
    assert_instance_of Array, dr.district
  end

  def test_find_all_matching_returns_empty_array_if_no_matching
    dr = DistrictRepository.new
    dr.load_data
    dr.find_all_matching("xyzz")
    assert_equal [], dr.district
  end

  def test_find_all_matching_array_contains_hashes
    dr = DistrictRepository.new
    dr.load_data
    dr.find_all_matching("we")
    assert_instance_of Hash, dr.district[0]
  end
end
