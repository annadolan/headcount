require_relative 'enrollment_repository'
require_relative 'shared_methods'
require_relative 'kindergarten'
require 'pry'

class Enrollment

  include SharedMethods
  include Kindergarten

  attr_reader :name, :enrollment_data, :district_name

  def initialize(name_and_enrollment_data)
    @name = name_and_enrollment_data[:name]
    @enrollment_data = name_and_enrollment_data[:kindergarten_participation] # make this more widely applicable
  end

end
