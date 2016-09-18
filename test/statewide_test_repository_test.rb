require './test/test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/statewide_test_repository'
require 'pry'

class StatewideTestRepositoryTest < Minitest::Test
  def test_str_loads_a_hash
    str = StatewideTestRepository.new
    str.load_data({
      :statewide_testing => {
        :third_grade => "./fixtures/3rd grade students scoring proficient or above on the CSAP_TCAP fixture.csv",
        :eighth_grade => "./fixtures/8th grade students scoring proficient or above on the CSAP_TCAP fixture.csv",
        :math => "./fixtures/Average proficiency on the CSAP_TCAP by race_ethnicity_ Math fixture.csv",
        :reading => "./fixtures/Average proficiency on the CSAP_TCAP by race_ethnicity_ Reading fixture.csv",
        :writing => "./fixtures/Average proficiency on the CSAP_TCAP by race_ethnicity_ Writing fixture.csv"
      }
      })
  assert_equal "COLORADO", str.statewide_repo.keys[0]
  end

  def test_find_by_name_returns_new_state_test_instance
    str = StatewideTestRepository.new
    str.load_data({
      :statewide_testing => {
        :third_grade => "./data/3rd grade students scoring proficient or above on the CSAP_TCAP.csv",
        :eighth_grade => "./data/8th grade students scoring proficient or above on the CSAP_TCAP.csv",
        :math => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Math.csv",
        :reading => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Reading.csv",
        :writing => "./data/Average proficiency on the CSAP_TCAP by race_ethnicity_ Writing.csv"
      }
    })

    assert_instance_of StatewideTest, str.find_by_name("Colorado")
  end
end
