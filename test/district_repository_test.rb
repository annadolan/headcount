require 'minitest/autorun'
require 'minitest/pride'
require './lib/district_repository'
require 'pry'

class DistrictRepositoryTest < Minitest::Test

  def test_dr_can_load_a_csv
    dr = DistrictRepository.new

    assert_instance_of Hash, dr.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv"
      }
    })
  end

  def test_dr_can_find_a_district_by_name
    dr = DistrictRepository.new
    dr.find_by_name("ACADEMY 20")
    assert_equal "0.49022", dr.district["data"]
  end

  def test_dr_can_find_using_just_a_fragment
    dr = DistrictRepository.new
    dr.find_all_matching("we")
    assert_equal 7, dr.district.count
  end
end
