require_relative 'district_repository'
require_relative 'grade_and_test_data'
require_relative 'result_entry'
require_relative 'headcount_analyst'
require_relative 'errors'
require_relative 'shared_methods'

class ResultSet
  attr_reader :matching_districts, :statewide_average
  
  
  def initialize(input)
    @matching_districts = input[:matching_districts]
    @statewide_average = input[:statewide_average]
  end
  
  def matching_districts
    @matching_districts
  end
  
  def statewide_average
    @statewide_average
  end
  
  binding.pry
  
end