require_relative 'enrollment_repository'
require_relative 'shared_methods'
require_relative 'enrollment_repository'

class District
  include SharedMethods
  attr_reader :name, :enrollment, :statewide_test, :economic_profile

  def initialize(name, enrollment_data = {}, statewide_test = {},
                economic_profile = {})
    @name = name[:name]
    @enrollment = enrollment_data[:information]
    @statewide_test = statewide_test[:statewide]
    @economic_profile = economic_profile[:economic]
  end



end
