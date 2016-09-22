require './test/test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/headcount_analyst'
require './lib/district_repository'
require 'pry'

class HeadcountAnalystTest < Minitest::Test

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
  
  def test_headcount_can_test_high_school_variation
    dr = DistrictRepository.new
    dr.load_data({
                   :enrollment => {
                     :kindergarten => "./data/Kindergartners in full-day program.csv",
                     :high_school_graduation => "./data/High school graduation rates.csv"
                   }
                 })
    ha = HeadcountAnalyst.new(dr)
    assert_equal 1.195, ha.high_school_graduation_rate_variation("ACADEMY 20", "COLORADO")
  end
  
  def test_headcount_can_test_kg_participation_against_hs_graduation
    dr = DistrictRepository.new
    dr.load_data({
                   :enrollment => {
                     :kindergarten => "./data/Kindergartners in full-day program.csv",
                     :high_school_graduation => "./data/High school graduation rates.csv"
                   }
                 })
    ha = HeadcountAnalyst.new(dr)
    assert_equal 0.641, ha.kindergarten_participation_against_high_school_graduation('ACADEMY 20')
  end
  
  def test_headcount_can_find_out_if_participation_correlates_with_graduation
    dr = DistrictRepository.new
    dr.load_data({
                   :enrollment => {
                     :kindergarten => "./data/Kindergartners in full-day program.csv",
                     :high_school_graduation => "./data/High school graduation rates.csv"
                   }
                 })
    ha = HeadcountAnalyst.new(dr)
    ha.kindergarten_participation_against_high_school_graduation('ACADEMY 20')
    assert ha.kindergarten_participation_correlates_with_high_school_graduation(for: 'ACADEMY 20')
    refute ha.kindergarten_participation_correlates_with_high_school_graduation(for: 'SIERRA GRANDE R-30')
  end
  
  def test_headcount_can_test_statewide_correlations
    dr = DistrictRepository.new
    dr.load_data({
                   :enrollment => {
                     :kindergarten => "./data/Kindergartners in full-day program.csv",
                     :high_school_graduation => "./data/High school graduation rates.csv"
                   }
                 })
    ha = HeadcountAnalyst.new(dr)
    refute ha.kindergarten_participation_correlates_with_high_school_graduation(:for => 'STATEWIDE')
  end
  
  def test_headcount_can_test_a_subset_of_districts
    dr = DistrictRepository.new
    dr.load_data({
                   :enrollment => {
                     :kindergarten => "./data/Kindergartners in full-day program.csv",
                     :high_school_graduation => "./data/High school graduation rates.csv"
                   }
                 })
    ha = HeadcountAnalyst.new(dr)
    districts = ["ACADEMY 20", 'PARK (ESTES PARK) R-3', 'YUMA SCHOOL DISTRICT 1']
    assert ha.kindergarten_participation_correlates_with_high_school_graduation(:across => districts)
  end
  
  def test_headcount_raises_insufficient_information_error_if_grade_is_not_provided
    dr = DistrictRepository.new
    dr.load_data({
                   :enrollment => {
                     :kindergarten => "./data/Kindergartners in full-day program.csv",
                     :high_school_graduation => "./data/High school graduation rates.csv"
                   }
                 })
    ha = HeadcountAnalyst.new(dr)
    assert_raises(InsufficientInformationError) do ha.top_statewide_test_year_over_year_growth(subject: :math)
    end
  end
  
  def test_headcount_raises_unknown_data_error_if_invalid_grade_entered
    dr = DistrictRepository.new
    dr.load_data({
                   :enrollment => {
                     :kindergarten => "./data/Kindergartners in full-day program.csv",
                     :high_school_graduation => "./data/High school graduation rates.csv"
                   }
                 })
    ha = HeadcountAnalyst.new(dr)
    assert_raises(UnknownDataError) do ha.top_statewide_test_year_over_year_growth(grade: 9, subject: :math)
    end
  end
  
  
  
end
