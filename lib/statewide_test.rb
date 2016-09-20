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
    result = proficient_by_grade(grade)
    result[year][subject]
  end

  def proficient_for_subject_by_race_in_year(subject, race, year)
    raise UnknownDataError unless SUBJECTS.include?(subject) && RACES.include?(race) && (year.class == Fixnum)
    result = proficient_by_race_or_ethnicity(race)
    result[year][subject]

  end

  def build_race_ethnicity_hash(subjects, race)
    race_ethnicity_hash = new_hash_ethnicity
    subjects.each do |subject|
      race_ethnicity_hash[2011][subject[0]] = truncate_float(clean_subject(subject[1], race)[0][0])
      race_ethnicity_hash[2012][subject[0]] = truncate_float(clean_subject(subject[1], race)[1][0])
      race_ethnicity_hash[2013][subject[0]] = truncate_float(clean_subject(subject[1], race)[2][0])
      race_ethnicity_hash[2014][subject[0]] = truncate_float(clean_subject(subject[1], race)[3][0])
    end
    @race_ethnicity_hash = race_ethnicity_hash
  end

  def clean_subject(subject, race)
    ethnicities = get_ethnicity(subject)
    subject_array = ethnicities[race.to_s.capitalize]
    if subject_array.nil?
      subject_data = [[0.001],[0.001],[0.001],[0.001]]
    else
      subject_data = subject_array.map do |item|
        if item.values[0].class != Float
          item.values = 0
        else
          item.values
        end
      end
    end
    subject_data
  end

  def clean_grade(grade_to_clean)
     year_array = get_year(grade_to_clean)
     subject_array = get_subject(get_year(grade_to_clean))
     subject_array.uniq!
     years = years(year_array)
    grouped = get_grouped(subject_array)

    math_array = grouped[:math]
    reading_array = grouped[:reading]
    writing_array = grouped[:writing]

    # final_hash = new_hash_statewide
      # final_hash[2008] = math_array[0], reading_array[0], writing_array[0]
      # final_hash[2009] = math_array[1], reading_array[1], writing_array[1]
      # final_hash[2010] = math_array[2], reading_array[2], writing_array[2]
      # final_hash[2011] = math_array[3], reading_array[3], writing_array[3]
      # final_hash[2012] = math_array[4], reading_array[4], writing_array[4]
      # final_hash[2013] = math_array[5], reading_array[5], writing_array[5]
      # final_hash[2014] = math_array[6], reading_array[6], writing_array[6]

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

  def array_length_validator(array)
    array.sort_by { |arr| arr.length }.reverse
  end

  def make_final_hash(years, math_array, reading_array, writing_array)

    years = [2008, 2009, 2010, 2011, 2012, 2013, 2014]
    ordered_arrays = array_length_validator([math_array, reading_array, writing_array])
    new_array = years.zip(ordered_arrays[0].zip(ordered_arrays[1], ordered_arrays[2]))
     new_array.each do |item|
       temp_hash = item_validator(item)
       
      final_hash[item[0]] = {:math => truncate_float(temp_hash[1][0][:math]),
                            :reading => truncate_float(temp_hash[1][1][:reading]),
                            :writing => truncate_float(temp_hash[1][2][:writing])
                            }
      end
      binding.pry


    final_hash

  end

  def item_validator(argument)
    argument[1].map do |hash|
      hash.nil? ? {} : hash
    end
  end
 #  def new_hash_statewide
 #    { 2008 => {:math => 0, :reading => 0, :writing => 0},
 #     2009 => {:math => 0, :reading => 0, :writing => 0},
 #     2010 => {:math => 0, :reading => 0, :writing => 0},
 #     2011 => {:math => 0, :reading => 0, :writing => 0},
 #     2012 => {:math => 0, :reading => 0, :writing => 0},
 #     2013 => {:math => 0, :reading => 0, :writing => 0},
 #     2014 => {:math => 0, :reading => 0, :writing => 0}
 #   }
 # end

  def new_hash_ethnicity
    setup_ethnicity_hash =
    { 2011=>{:math=>nil, :reading=>nil, :writing=>nil},
      2012=>{:math=>nil, :reading=>nil, :writing=>nil},
      2013=>{:math=>nil, :reading=>nil, :writing=>nil},
      2014=>{:math=>nil, :reading=>nil, :writing=>nil}}
  end
end
