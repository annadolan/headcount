require 'statewide_test_repository'
require 'shared_methods'
require 'kindergarten'
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
  
end