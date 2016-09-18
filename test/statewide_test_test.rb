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

  def test_proficient_by_grade_raises_error
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
    st = StatewideTest.new("Colorado")
    assert_raises(UnknownDataError) do st.proficient_by_grade(6)
    end
  end

  def test_proficient_by_grade_matches_grade
    skip
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
    st = str.find_by_name("ACADEMY 20")
    assert_equal st.eighth_grade, st.proficient_by_grade(8)

  end

  def test_clean_grade_returns_cleaned_grade
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
    st = str.find_by_name("ACADEMY 20")
    st.proficient_by_grade(3)
    assert_equal ({:math => 0.857, :reading => 0.866, :writing => 0.671}), cleaned_grade[2008]

  end



end
