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

  def test_kindergarten_participation_rate_variation_trend_has_two_instances_of_district
    dr = DistrictRepository.new
    dr.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv"
      }
    })
    ha = HeadcountAnalyst.new(dr)
    ha.kindergarten_participation_rate_variation_trend("ACADEMY 20", "COLORADO")
    assert_instance_of District, ha.dist1
    assert_instance_of District, ha.dist2
  end
  
  def test_headcount_analyst_can_check_high_school_grad_rate
    dr = DistrictRepository.new
    dr.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv",
        :high_school_graduation => "./data/High school graduation rates.csv"
      }
    })
    ha = HeadcountAnalyst.new(dr)
    assert_equal 0.222, ha.high_school_graduation_rate_variation("ACADEMY 20", "COLORADO")
  end
  
  def test_headcount_analyst_can_check_kindergarten_against_high_school
    skip
    dr = DistrictRepository.new
    dr.load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv",
        :high_school_graduation => "./data/High school graduation rates.csv"
      }
    })
    ha = HeadcountAnalyst.new(dr)
    assert_equal 0.222, ha.kindergarten_participation_against_high_school_graduation('ACADEMY 20')
  end
end
