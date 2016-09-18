require_relative 'statewide_test_repository'
require_relative 'shared_methods'
require_relative 'kindergarten'
require 'pry'

class StatewideTest < StatewideTestRepository

  include SharedMethods
  include Kindergarten

  attr_accessor :name, :third_grade, :eighth_grade, :math,
                :reading, :writing

  def initialize(name)
    @name = name
    @third_grade = third_grade
    @eighth_grade = eighth_grade
    @math = math
    @reading = reading
    @writing = writing
  end

  def proficient_by_grade(grade)
  end

end
