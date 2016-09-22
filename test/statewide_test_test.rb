require './test/test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/statewide_test'
require 'pry'

class StatewideTestTest < Minitest::Test

  include SharedMethods

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

  def test_proficient_by_grade_matches_grade_data
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
    st.proficient_by_grade(8)
    assert_equal ({:math=>0.640, :reading=>0.843, :writing=>0.734}), st.final_hash[2008]
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
    assert_equal ({:math => 0.857, :reading => 0.866, :writing => 0.671}), st.final_hash[2008]
    assert_equal ({:math => 0.819, :reading => 0.867, :writing => 0.678}), st.final_hash[2011]
    assert_equal ({:math => 0.834, :reading => 0.831, :writing => 0.639}), st.final_hash[2014]
  end

  def test_proficient_by_race_or_ethnicity_throws_error_if_given_unknown_race
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
    assert_raises(UnknownRaceError) do st.proficient_by_race_or_ethnicity(:martian)
    end
  end

  def test_proficient_by_race_or_ethnicity_returns_correct_data
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
    result = st.proficient_by_race_or_ethnicity(:asian)
    assert_equal ({:math => 0.818, :reading => 0.893, :writing => 0.808}), st.race_ethnicity_hash[2012]
    assert_equal ({:math => 0.800, :reading => 0.855, :writing => 0.789}), st.race_ethnicity_hash[2014]
  end


  def test_proficient_for_subject_by_grade_in_year_returns_error_if_given_incorrect_subject
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
      assert_raises(UnknownDataError) do st.proficient_for_subject_by_grade_in_year(:transmogrification, 3, 2012)
    end
  end

  def test_proficient_for_subject_by_grade_in_year_returns_error_if_given_incorrect_subject
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
      assert_equal 0.857, st.proficient_for_subject_by_grade_in_year(:math, 3, 2008)
      assert_equal 0.843, st.proficient_for_subject_by_grade_in_year(:reading, 8, 2008)
      assert_equal 0.831, st.proficient_for_subject_by_grade_in_year(:reading, 3, 2014)

  end

  def test_proficient_for_subject_by_race_in_year_returns_error_if_given_bad_input
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
      assert_raises(UnknownDataError) do st.proficient_for_subject_by_grade_in_year(:boink, :white, 2008)
  end

  def test_proficient_for_subject_by_race_in_year_returns_correct_data
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
      assert_equal 0.604, st.proficient_for_subject_by_race_in_year(:math, :hispanic, 2014)
    end
  end
end
