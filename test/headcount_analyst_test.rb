require './test/test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/headcount_analyst'
require './lib/district_repository'
require 'pry'

class HeadcountAnalystTest < Minitest::Test
  def test_kindergarten_participation_rate_variation_has_two_instances_of_district
    dr = DistrictRepository.new
    dr.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv"
      }
    })
    ha = HeadcountAnalyst.new(dr)
    ha.kindergarten_participation_rate_variation("ACADEMY 20", "COLORADO")
    assert_instance_of District, ha.dist1
    assert_instance_of District, ha.dist2
  end

  def test_kindergarten_participation_rate_variation_returns_float
    dr = DistrictRepository.new
    dr.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv"
      }
    })
    ha = HeadcountAnalyst.new(dr)
    assert_instance_of Float, ha.kindergarten_participation_rate_variation("ACADEMY 20", "COLORADO")
  end
end
