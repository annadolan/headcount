require_relative 'statewide_test_repository'
require_relative 'grade_and_test_data'
require_relative 'shared_methods'
require_relative 'errors'
require 'pry'

class StatewideTest

  include SharedMethods
  include GradeAndTestData

  attr_reader :grades
  attr_accessor :name, :third_grade, :eighth_grade, :math,
                :reading, :writing, :final_hash, :race_ethnicity_hash

  GRADES = [3, 8]
  RACES = [:asian, :black, :pacific_islander, :hispanic, :native_american,
            :two_or_more, :white]
  SUBJECTS = [:math, :reading, :writing]

  def initialize(name)
    @name = name
    @third_grade = third_grade
    @eighth_grade = eighth_grade
    @math = math
    @reading = reading
    @writing = writing
    @final_hash = {}
    @race_ethnicity_hash = {}
  end

  def proficient_by_grade(grade)
    raise UnknownDataError unless GRADES.include?(grade)
    if grade == 3
      grade_to_clean = third_grade
    elsif grade == 8
      grade_to_clean = eighth_grade
    end
    clean_grade(grade_to_clean)
  end

  def proficient_by_race_or_ethnicity(race)
    raise UnknownRaceError unless RACES.include?(race)
    subjects = [[:math, math], [:reading, reading], [:writing, writing]]
    build_race_ethnicity_hash(subjects, race)
  end

  def proficient_for_subject_by_grade_in_year(subject, grade, year)
    raise UnknownDataError unless SUBJECTS.include?(subject)
    grade
    result = proficient_by_grade(grade)
    final_result = result[year][subject]
    if final_result == 0.0 || final_result == nil
      final_result = "N/A"
    end
    final_result
  end

  def proficient_for_subject_by_race_in_year(subject, race, year)
    raise UnknownDataError unless
    SUBJECTS.include?(subject) && RACES.include?(race) && (year.class == Fixnum)
    result = proficient_by_race_or_ethnicity(race)
    result[year][subject]
  end

  def build_race_ethnicity_hash(subjects, race)
    race_ethnicity_hash = new_hash_ethnicity
    subjects.each do |subject|
      race_ethnicity_hash[2011][subject[0]] =
                        truncate_float(clean_subject(subject[1], race)[0][0])
      race_ethnicity_hash[2012][subject[0]] =
                        truncate_float(clean_subject(subject[1], race)[1][0])
      race_ethnicity_hash[2013][subject[0]] =
                        truncate_float(clean_subject(subject[1], race)[2][0])
      race_ethnicity_hash[2014][subject[0]] =
                        truncate_float(clean_subject(subject[1], race)[3][0])
    end
    @race_ethnicity_hash = race_ethnicity_hash
  end

  def make_final_hash(years, math_array, reading_array, writing_array)
    new_array = years.zip(math_array.zip(reading_array, writing_array))
    new_array.each do |item|
      final_hash[item[0]] = {:math => truncate_float(item[1][0][:math]),
                            :reading => truncate_float(item[1][1][:reading]),
                            :writing => truncate_float(item[1][2][:writing])
                            }
      end
    final_hash
  end

  def new_hash_ethnicity
    setup_ethnicity_hash =
    { 2011=>{:math=>nil, :reading=>nil, :writing=>nil},
      2012=>{:math=>nil, :reading=>nil, :writing=>nil},
      2013=>{:math=>nil, :reading=>nil, :writing=>nil},
      2014=>{:math=>nil, :reading=>nil, :writing=>nil}}
  end
end
