require_relative 'enrollment_repository'
require_relative 'shared_methods'
require_relative 'kindergarten'
require_relative 'enrollment_repository'

class District

  include SharedMethods
  include Kindergarten

  attr_reader :name, :enrollment

  def initialize(name, enrollment_data = {})
    @name = name[:name]
    @enrollment = enrollment_data[:information]
  end



end
