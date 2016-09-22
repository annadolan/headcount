require './test/test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/shared_methods'
require './lib/economic_profile_repository'
require './lib/economic_profile'
require 'pry'

class EconomicProfileTest < Minitest::Test

  include SharedMethods

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
    ep = epr.find_by_name("BRIGGSDALE RE-10")
    assert_equal 61071.0, ep.data[:median_household_income].values[2]
    assert_equal 0.162, ep.data[:children_in_poverty].values[0]
    assert_equal 0.16, ep.data[:free_or_reduced_price_lunch].values[0].values[0]
    assert_equal 0.012, ep.data[:title_i].values[0]
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
    ep = epr.find_by_name("BRIGGSDALE RE-10")
    assert_equal 43750, ep.median_household_income_in_year(2005)
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
    ep = epr.find_by_name("BRIGGSDALE RE-10")
    assert_equal 53569, ep.median_household_income_average
  end

  def test_ep_can_return_child_poverty_in_year
    epr = EconomicProfileRepository.new
    epr.load_data({
      :economic_profile => {
        :median_household_income => "./fixtures/Median household income fixture.csv",
        :children_in_poverty => "./fixtures/School-aged children in poverty fixture.csv",
        :free_or_reduced_price_lunch => "./fixtures/Students qualifying for free or reduced price lunch fixture.csv",
        :title_i => "./fixtures/Title I students fixture.csv"
      }
      })
    ep = epr.find_by_name("BRIGGSDALE RE-10")
    assert_equal 0.162, ep.children_in_poverty_in_year(2012)
  end

  def test_ep_throws_an_error_if_asked_for_child_poverty_in_year_it_does_not_recognize
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
    assert_raises(UnknownDataError) do ep.children_in_poverty_in_year(3000)
    end
  end

  def test_ep_can_return_free_or_reduced_price_lunch_percent_in_year
    data = {  :median_household_income => {[2014, 2015] => 50000, [2013, 2014] => 60000},
              :children_in_poverty => {2012 => 0.1845},
              :free_or_reduced_price_lunch => {2014 => {:percentage => 0.123, :total => 100}},
              :title_i => {2015 => 0.543},
             }
    ep = EconomicProfile.new(data)
    assert_equal 0.123, ep.free_or_reduced_price_lunch_percentage_in_year(2014)
  end

  def test_ep_throws_an_error_if_asked_for_lunch_percents_in_year_it_does_not_recognize
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
    assert_raises(UnknownDataError) do ep.free_or_reduced_price_lunch_percentage_in_year(3000)
    end
  end

  def test_ep_can_return_free_or_reduced_price_lunch_number_in_year
    data = {  :median_household_income => {[2014, 2015] => 50000, [2013, 2014] => 60000},
              :children_in_poverty => {2012 => 0.1845},
              :free_or_reduced_price_lunch => {2014 => {:percentage => 0.123, :total => 100}},
              :title_i => {2015 => 0.543},
             }
    ep = EconomicProfile.new(data)
    assert_equal 100, ep.free_or_reduced_price_lunch_number_in_year(2014)
  end

  def test_ep_throws_an_error_if_asked_for_lunch_numbers_in_year_it_does_not_recognize
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
    assert_raises(UnknownDataError) do ep.free_or_reduced_price_lunch_number_in_year(3000)
    end
  end

  def test_ep_can_return_title_i_in_year
    data = {  :median_household_income => {[2014, 2015] => 50000, [2013, 2014] => 60000},
              :children_in_poverty => {2012 => 0.1845},
              :free_or_reduced_price_lunch => {2014 => {:percentage => 0.123, :total => 100}},
              :title_i => {2015 => 0.543},
             }
    ep = EconomicProfile.new(data)
    assert_equal 0.543, ep.title_i_in_year(2014)
  end

  def test_ep_throws_an_error_if_asked_for_lunch_numbers_in_year_it_does_not_recognize
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
    assert_raises(UnknownDataError) do ep.title_i_in_year(3000)
    end
  end

end
