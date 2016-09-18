require './test/test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/statewide_test'
require 'pry'

class StatewideTestTest < Minitest::Test
  def test_instance_of_statewide_test
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
    st = StatewideTest.new("Colorado")
    assert_instance_of StatewideTest, st
  end




end
