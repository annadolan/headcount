require_relative 'statewide_test_repository'
require_relative 'shared_methods'
require_relative 'kindergarten'
require_relative 'errors'
require 'pry'

class StatewideTest < StatewideTestRepository

  include SharedMethods
  include Kindergarten

  attr_reader :grades
  attr_accessor :name, :third_grade, :eighth_grade, :math,
                :reading, :writing, :final_hash

  GRADES = [3, 8]
  RACES = [:asian, :black, :pacific_islander, :hispanic, :native_american,
            :two_or_more, :white]

  def initialize(name)
    @name = name
    @third_grade = third_grade
    @eighth_grade = eighth_grade
    @math = math
    @reading = reading
    @writing = writing
    @final_hash = {}
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
    race_to_parse = race
    build_race_ethnicity_hash(race)
    # clean_math = clean_subject(math, race)
    # clean_reading = clean_subject(reading, race)
    # clean_writing = clean_subject(writing, race)
    # clean_grade(@math)
  end

  def build_race_ethnicity_hash(race)
    race_ethnicity_hash = new_hash_ethnicity
     race_ethnicity_hash[2011][:math] = truncate_float(clean_subject(math, race)[0][0])
     race_ethnicity_hash[2012][:math] = truncate_float(clean_subject(math, race)[1][0])
     race_ethnicity_hash[2013][:math] = truncate_float(clean_subject(math, race)[2][0])
     race_ethnicity_hash[2014][:math] = truncate_float(clean_subject(math, race)[3][0])
     race_ethnicity_hash[2011][:reading] = truncate_float(clean_subject(reading, race)[0][0])
     race_ethnicity_hash[2012][:reading] = truncate_float(clean_subject(reading, race)[1][0])
     race_ethnicity_hash[2013][:reading] = truncate_float(clean_subject(reading, race)[2][0])
     race_ethnicity_hash[2014][:reading] = truncate_float(clean_subject(reading, race)[3][0])
     race_ethnicity_hash[2011][:writing] = truncate_float(clean_subject(writing, race)[0][0])
     race_ethnicity_hash[2012][:writing] = truncate_float(clean_subject(writing, race)[1][0])
     race_ethnicity_hash[2013][:writing] = truncate_float(clean_subject(writing, race)[2][0])
     race_ethnicity_hash[2014][:writing] = truncate_float(clean_subject(writing, race)[3][0])
     race_ethnicity_hash
  end

  def new_hash_ethnicity
    setup_ethnicity_hash =
    { 2011=>{:math=>nil, :reading=>nil, :writing=>nil},
      2012=>{:math=>nil, :reading=>nil, :writing=>nil},
      2013=>{:math=>nil, :reading=>nil, :writing=>nil},
      2014=>{:math=>nil, :reading=>nil, :writing=>nil}}
  end
  def clean_subject(subject, race)
    ethnicities = get_ethnicity(subject)
    year_array = get_year(subject)
    years = years(year_array)
    subject_array = ethnicities[race.to_s.capitalize]
    subject_data = subject_array.map do |item|
      item.values
    end
  end

  def clean_grade(grade_to_clean)
    year_array = get_year(grade_to_clean)
    subject_array = get_subject(get_year(grade_to_clean))
    years = years(year_array)
    grouped = get_grouped(subject_array)
    math_array = grouped[:math]
    reading_array = grouped[:reading]
    writing_array = grouped[:writing]
    make_final_hash(years, math_array, reading_array, writing_array)
  end

  def get_year(grade_to_clean)
    year_array = []
    grade_to_clean.each do |elem|
      year_array << elem.values
    end
    year_array = year_array.flatten
    year_array.sort_by! {|hsh| hsh.keys }

  end

  def get_subject(year_array)
    subject_array = []
    year_array.each do |elem|
      subject_array << elem.values
    end
    subject_array = subject_array.flatten

  end

  def get_ethnicity(subject)
    ethnicity = []
    subject.each_with_index do |elem, i|
      ethnicity << subject[i].values[0].values
    end
    ethnicity.flatten!
    ethnicity.group_by {|item| item.keys[0]}
  end

  def get_grouped(subject_array)
    values_array = []
    subject_array.each do |elem|
      values_array << {elem.keys[0].downcase.to_sym => elem.values[0]}
    end
    grouped = values_array.group_by {|elem| elem.keys[0]}
  end

  def years(year_array)
    years = []
    year_array.each do |elem|
      years << elem.keys[0].to_i
    end
    years.uniq!
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
end
