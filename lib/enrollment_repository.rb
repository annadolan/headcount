require_relative 'shared_methods'
require_relative 'enrollment'
require_relative 'kindergarten'

class EnrollmentRepository
  include SharedMethods
  include Kindergarten

  attr_reader :district, :enrollments, :input

  def initialize
    @enrollments = {}
  end

  def load_data(path)
    load_into_hash_kindergarten(path)
    load_into_hash_high_school(path)
    populate(path)
  end
  
  def populate(path)
    input_1 = organized_entries_kg
    input_2 = organized_entries_hs
    @enrollments = Enrollment.new({
        :kindergarten_participation => input_1,
        :high_school_graduation => input_2 })
  end

  def find_by_name(district_name) 
    
  end


end
