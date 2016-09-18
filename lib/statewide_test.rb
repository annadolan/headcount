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
    binding.pry
    clean_grade(grade_to_clean)
  end

  def clean_grade(grade_to_clean)
    new_hash[grade_to_clean]

  end

end
