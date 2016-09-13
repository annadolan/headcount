require_relative 'enrollment_repository'
require_relative 'shared_methods'

class Enrollment
  
  include SharedMethods

  attr_reader :name, :enrollment_data, :district_name
  
  def initialize(name_and_enrollment_data)
    @name = name_and_enrollment_data[:name]
    @enrollment_data = name_and_enrollment_data[:kindergarten_participation]
  end
  
  def kindergarten_participation_by_year
    @enrollment_data
  end
  
  
  def kindergarten_participation_in_year(year)
    @enrollment_data[year]
  end
  
end