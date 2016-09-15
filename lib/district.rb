require_relative 'enrollment_repository'
require_relative 'shared_methods'
require_relative 'kindergarten'

class District
  
  include SharedMethods
  include Kindergarten
  
  attr_reader :name, :enrollment, :district_name, :enrollment_data
 
  def initialize(name_and_enrollment_data)
    @name = name_and_enrollment_data[:name]
    @enrollment = Enrollment.new(name_and_enrollment_data)
  end



end
