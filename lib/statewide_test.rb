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
                :reading, :writing

  def initialize(name)
    @name = name
    @third_grade = third_grade
    @eighth_grade = eighth_grade
    @math = math
    @reading = reading
    @writing = writing
    @grades = [3, 8]
  end

  def proficient_by_grade(grade)
    raise UnknownDataError unless grades.include?(grade)
    if grade == 3
      grade_to_clean = third_grade
    elsif grade == 8
      grade_to_clean = eighth_grade
    end
    clean_grade(grade_to_clean)
  end

  def clean_grade(grade_to_clean)
    year_array = get_year(grade_to_clean)
    subject_array = get_subject(get_year(grade_to_clean))
    data_array = get_data(get_subject(get_year(grade_to_clean)))

    values_array = []
    subject_array.each do |elem|
      values_array << {elem.keys[0].downcase.to_sym => elem.values[0]}
    end
    years = []
    year_array.each do |elem|
      years << elem.keys[0].to_i
    end
    years.uniq!
    grouped = values_array.group_by {|elem| elem.keys[0]}
    math_array = grouped[:math]
    reading_array = grouped[:reading]
    writing_array = grouped[:writing]

    array = math_array.zip(reading_array, writing_array)
    new_array = years.zip(array)
    final_hash = {}
    new_array.each do |item|
      final_hash[item[0]] = {:math => truncate_float(item[1][0][:math]),
                            :reading => truncate_float(item[1][1][:reading]),
                            :writing => truncate_float(item[1][2][:writing])
                            }
      end

    # math_hash = Hash[years.zip(math_array)]
    # reading_hash = Hash[years.zip(reading_array)]
    # writing_hash = Hash[years.zip(writing_array)]
     binding.pry
  end

  def get_year(grade_to_clean)
    year_array = []
    grade_to_clean.each do |elem|
      year_array << elem.values
    end
    year_array = year_array.flatten

  end

  def get_subject(year_array)
    subject_array = []
    year_array.each do |elem|
      subject_array << elem.values
    end
    subject_array = subject_array.flatten

  end

  def get_data(subject_array)
    data_array = []
    subject_array.each do |elem|
      data_array << elem.values
    end
    data_array = data_array.flatten

  end

end
