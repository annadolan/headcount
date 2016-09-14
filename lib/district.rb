require_relative 'district_repository'
require_relative 'enrollment'
require_relative 'kindergarten'
require_relative 'shared_methods'

class District
  attr_reader :name, :enrollment, :district_name
  include SharedMethods
  include Kindergarten


  def initialize(name, enrollment_information)
    @name = name_and_enrollment_data[:name]
    @enrollment = enrollment_generator(name_and_enrollment_data[:kindergarten_participation])
  end




end
