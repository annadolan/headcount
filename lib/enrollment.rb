require_relative 'enrollment_repository'
require_relative 'shared_methods'
require_relative 'kindergarten'
require 'pry'

class Enrollment

  include SharedMethods
  include Kindergarten

  attr_reader :name, :enrollment_kg, :enrollment_hs, :district_name

  def initialize(name_and_enrollment_data)
    @name = name_and_enrollment_data[:name]
    @enrollment_kg = name_and_enrollment_data[:kindergarten_participation]
    @enrollment_hs = name_and_enrollment_data[:high_school_graduation]
  end

end
