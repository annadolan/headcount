require_relative 'enrollment_repository'
require_relative 'shared_methods'

class Enrollment
  
  include SharedMethods

  attr_reader :name, :enrollment_data, :district_name
  
  def initialize(district_name)
    @name = district_name[:name]
    @enrollment_data = enrollment_data
  end
  
  def kindergarten_participation_by_year
    @enrollment_data = [:kindergarten_participation]
  end
  
end