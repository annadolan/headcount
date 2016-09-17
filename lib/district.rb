require_relative 'enrollment_repository'
require_relative 'shared_methods'
require_relative 'kindergarten'
require_relative 'enrollment_repository'

class District

  include SharedMethods
  include Kindergarten

  attr_reader :name, :enrollment

  def initialize(name_and_enrollment_data)
    @name = name_and_enrollment_data[:name]
    @enrollment = @enrollments[name_and_enrollment_data]
  end



end
