require 'statewide_test_repository'
require 'shared_methods'
require 'kindergarten'
require 'pry'

class StatewideTest
  
  include SharedMethods
  include Kindergarten
  
  def initialize(name)
    @name = name
    @third_grade = third_grade[name]
    @eighth_grade = eighth_grade[name]
    @math = math_ethnicity[name]
    @reading = reading_ethnicity[name]
    @writing = writing_ethnicity[name]
  end
  
  
end