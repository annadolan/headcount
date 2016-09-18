require 'pry'
require_relative 'shared_methods'
require_relative 'kindergarten'

class StatewideTestRepository
  include SharedMethods
  include Kindergarten
  attr_accessor :statewide_repo, :tests_array

  def initialize
    @statewide_repo = {}
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
    if input_contains_ethnicity_data(input) == false
      third_grade = load_statewide_csv(path[:third_grade], :third_grade)
      eighth_grade = load_statewide_csv(path[:eighth_grade], :eighth_grade)
    else
      third_grade = load_statewide_csv(path[:third_grade], :third_grade)
      eighth_grade = load_statewide_csv(path[:eighth_grade], :eighth_grade)
      math_ethnicity = load_statewide_csv(path[:math], :math)
      reading_ethnicity = load_statewide_csv(path[:reading], :reading)
      writing_ethnicity = load_statewide_csv(path[:writing], :writing)
    end
  
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
  
  def new_state_repo(all_testing_data)
    all_testing_data.map do |elem|
      testing_obj = StatewideTest.new(elem)
      statewide_repo[elem[:name]] = testing_obj
    end
    @statewide_repo
  end  

end
