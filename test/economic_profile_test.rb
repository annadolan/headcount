require './test/test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/shared_methods'
require './lib/kindergarten'
require './lib/economic_profile_repository'
require './lib/economic_profile'
require 'pry'

class EconomicProfileTest < Minitest::Test
  
  include SharedMethods
  include Kindergarten
  
  def test_ep_data_exists
    epr = EconomicProfileRepository.new
    epr.load_data({
      :economic_profile => {
        :median_household_income => "./fixtures/Median household income fixture.csv",
        :children_in_poverty => "./fixtures/School-aged children in poverty fixture.csv",
        :free_or_reduced_price_lunch => "./fixtures/Students qualifying for free or reduced price lunch fixture.csv",
        :title_i => "./fixtures/Title I students fixture.csv"
      }
      })
    ep = epr.find_by_name("ACADEMY 20")
    assert_instance_of EconomicProfile, ep
  end
  
  def test_ep_data_has_relevant_data
    epr = EconomicProfileRepository.new
    epr.load_data({
      :economic_profile => {
        :median_household_income => "./fixtures/Median household income fixture.csv",
        :children_in_poverty => "./fixtures/School-aged children in poverty fixture.csv",
        :free_or_reduced_price_lunch => "./fixtures/Students qualifying for free or reduced price lunch fixture.csv",
        :title_i => "./fixtures/Title I students fixture.csv"
      }
      })
    ep = epr.find_by_name("ACADEMY 20")
    assert_instance_of EconomicProfile, ep
    assert_equal 85060.0, ep.data[0][:median_household_income][0]["ACADEMY 20"].values[0]
    assert_equal 0.034, ep.data[1][:children_in_poverty][7]["ACADEMY 20"].values[0]
    assert_equal 976.0, ep.data[2][:free_or_reduced_price_lunch][3]["ACADEMY 20"].values[0].values[0]
    assert_equal 0.011, ep.data[3][:title_i][1]["ACADEMY 20"].values[0]
  end
  
  def test_ep_returns_error_if_given_invalid_year
    epr = EconomicProfileRepository.new
    epr.load_data({
      :economic_profile => {
        :median_household_income => "./fixtures/Median household income fixture.csv",
        :children_in_poverty => "./fixtures/School-aged children in poverty fixture.csv",
        :free_or_reduced_price_lunch => "./fixtures/Students qualifying for free or reduced price lunch fixture.csv",
        :title_i => "./fixtures/Title I students fixture.csv"
      }
      })
    ep = epr.find_by_name("ACADEMY 20")
    assert_raises(UnknownDataError) do ep.median_household_income_in_year(3000)
    end
  end
  
  def test_ep_can_find_median_household_income_in_years
    epr = EconomicProfileRepository.new
    epr.load_data({
      :economic_profile => {
        :median_household_income => "./fixtures/Median household income fixture.csv",
        :children_in_poverty => "./fixtures/School-aged children in poverty fixture.csv",
        :free_or_reduced_price_lunch => "./fixtures/Students qualifying for free or reduced price lunch fixture.csv",
        :title_i => "./fixtures/Title I students fixture.csv"
      }
      })
    ep = epr.find_by_name("ACADEMY 20")
    assert_equal 85060, ep.median_household_income_in_year(2005)
  end
  
  def test_ep_can_return_the_median_household_income_average
    epr = EconomicProfileRepository.new
    epr.load_data({
      :economic_profile => {
        :median_household_income => "./fixtures/Median household income fixture.csv",
        :children_in_poverty => "./fixtures/School-aged children in poverty fixture.csv",
        :free_or_reduced_price_lunch => "./fixtures/Students qualifying for free or reduced price lunch fixture.csv",
        :title_i => "./fixtures/Title I students fixture.csv"
      }
      })
    ep = epr.find_by_name("ACADEMY 20")
    assert_equal 87635, ep.median_household_income_average
    ep_2 = epr.find_by_name("AGUILAR REORGANIZED")
    binding.pry
    assert_equal 87635, ep_2.median_household_income_average
  end
  
  
  
end