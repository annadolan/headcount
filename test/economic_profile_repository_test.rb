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
      binding.pry
    assert_instance_of Hash, epr.economic_repo
  end
  
  
  
  
  
end