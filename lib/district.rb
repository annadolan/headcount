require_relative 'district_repository'
require_relative 'enrollment'
require_relative 'shared_methods'

class District
  attr_reader :name, :enrollment, :district_name
  include SharedMethods

  def initialize(name_and_enrollment_data)
    @name = name_and_enrollment_data[:name]
    @enrollment = name_and_enrollment_data[:kindergarten_participation]

  end
  # def initialize(district_input)
  #   @name = district_input[:name]
  # end

end
