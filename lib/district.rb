require_relative 'enrollment_repository'
require_relative 'shared_methods'
require_relative 'kindergarten'
require_relative 'enrollment_repository'

class District

  include SharedMethods
  include Kindergarten

  attr_reader :name, :enrollment, :statewide_test

  def initialize(name, enrollment_data = {}, statewide_test = {})
    @name = name[:name]
    @enrollment = enrollment_data[:information]
    @statewide_test = statewide_test[:statewide]
  end



end
