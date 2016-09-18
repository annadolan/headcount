require 'pry'
require_relative 'shared_methods'
require_relative 'kindergarten'

class StatewideTestRepository
  include SharedMethods
  include Kindergarten
  attr_accessor :statewide_repo, :tests_array
  attr_reader :third_grade, :eighth_grade, :math_ethnicity,
              :reading_ethnicity, :writing_ethnicity

  def initialize
    @statewide_repo = {}
    @third_grade = {}
    @eighth_grade = {}
    @math_ethnicity = {}
    @reading_ethnicity = {}
    @writing_ethnicity = {}
  end

  def load_statewide_csv(path, key)
    tests_array = []
    CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
      if path.include?("Average")
        tests_array << ({row[:location] => {row[:timeframe] => {row[:race_ethnicity] => row[:data].to_f}}})
      else
        tests_array << ({row[:location] => {row[:timeframe] => {row[:score] => row[:data].to_f}}})
      end
      tests_array
    end
    parse_testing(tests_array, key)
  end

  def load_data(input)
    path = input[:statewide_testing]
    if input_contains_ethnicity_data(input)
      @third_grade = load_statewide_csv(path[:third_grade], :third_grade)
      @eighth_grade = load_statewide_csv(path[:eighth_grade], :eighth_grade)
    else
      @third_grade = load_statewide_csv(path[:third_grade], :third_grade)
      @eighth_grade = load_statewide_csv(path[:eighth_grade], :eighth_grade)
      @math_ethnicity = load_statewide_csv(path[:math], :math)
      @reading_ethnicity = load_statewide_csv(path[:reading], :reading)
      @writing_ethnicity = load_statewide_csv(path[:writing], :writing)
    end
    keys = third_grade.keys
    add_to_state_repo(keys)
  end

  def input_contains_ethnicity_data(input)
    if input[:statewide_testing][:math].nil?
      true
    elsif input[:statewide_testing][:reading].nil?
      true
    elsif input[:statewide_testing][:writing].nil?
      true
    else
      false
    end
  end

  def add_to_state_repo(keys)
    keys.map do |elem|
      elem = elem.upcase
      testing_obj = StatewideTest.new(elem)
      testing_obj.third_grade = third_grade[elem]
      testing_obj.eighth_grade = eighth_grade[elem]
      testing_obj.math = math_ethnicity[elem]
      testing_obj.reading = reading_ethnicity[elem]
      testing_obj.writing = writing_ethnicity[elem]
      @statewide_repo[elem] = testing_obj
    end
    @statewide_repo
  end

  def find_by_name(district_name)
    @statewide_repo[district_name.upcase]
  end

end
