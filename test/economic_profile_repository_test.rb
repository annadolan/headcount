require './test/test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/shared_methods'
require './lib/kindergarten'
require './lib/economic_profile_repository'
require 'pry'

class EconomicProfileRepositoryTest < Minitest::Test
  
  include SharedMethods
  include Kindergarten
  
  def test_economic_p_repo_can_load_data
    epr = EconomicProfileRepository.new
    epr.load_data({
      :economic_profile => {
        :median_household_income => "./fixtures/Median household income fixture.csv",
        :children_in_poverty => "./fixtures/School-aged children in poverty fixture.csv",
        :free_or_reduced_price_lunch => "./fixtures/Students qualifying for free or reduced price lunch fixture.csv",
        :title_i => "./fixtures/Title I students fixture.csv"
      }
      })
    assert_instance_of Hash, epr.economic_repo
  end
  
  def test_economic_p_repo_can_store_data_in_separate_hashes
    epr = EconomicProfileRepository.new
    epr.load_data({
      :economic_profile => {
        :median_household_income => "./fixtures/Median household income fixture.csv",
        :children_in_poverty => "./fixtures/School-aged children in poverty fixture.csv",
        :free_or_reduced_price_lunch => "./fixtures/Students qualifying for free or reduced price lunch fixture.csv",
        :title_i => "./fixtures/Title I students fixture.csv"
      }
      })
    assert_equal "Colorado", epr.median_household_income.keys[0]
    assert_equal "ACADEMY 20", epr.children_in_poverty.keys[0]
    assert_equal "Colorado", epr.free_or_reduced_price_lunch.keys[0]
    assert_equal "Colorado", epr.title_i.keys[0]

  end
  
  def test_economic_p_repo_find_data
    epr = EconomicProfileRepository.new
    epr.load_data({
      :economic_profile => {
        :median_household_income => "./fixtures/Median household income fixture.csv",
        :children_in_poverty => "./fixtures/School-aged children in poverty fixture.csv",
        :free_or_reduced_price_lunch => "./fixtures/Students qualifying for free or reduced price lunch fixture.csv",
        :title_i => "./fixtures/Title I students fixture.csv"
      }
      })
    assert_instance_of Hash, epr.economic_repo
  end
  
  def test_epr_load_data_can_create_an_array_of_profle_objects
    epr = EconomicProfileRepository.new
    epr.load_data({
      :economic_profile => {
        :median_household_income => "./fixtures/Median household income fixture.csv",
        :children_in_poverty => "./fixtures/School-aged children in poverty fixture.csv",
        :free_or_reduced_price_lunch => "./fixtures/Students qualifying for free or reduced price lunch fixture.csv",
        :title_i => "./fixtures/Title I students fixture.csv"
      }
      })
    assert_instance_of EconomicProfile, epr.economic_repo["ACADEMY 20"]
  end
  
  
  
  
  
end