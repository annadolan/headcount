require_relative 'enrollment_repository'
require_relative 'shared_methods'
require_relative 'kindergarten'
require 'pry'

class Enrollment

  include SharedMethods
  include Kindergarten

  def initialize(name_and_enrollment_data)
    @hash = name_and_enrollment_data
  end
  
  def kindergarten
    @hash[:kindergarten_participation]
  end
  
  def high_school
    @hash[:high_school_graduation]
  end

end
