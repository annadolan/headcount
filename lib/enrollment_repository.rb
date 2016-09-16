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
  end
  
  def populate(path)
    input = organized_entries
    district_name_upcase = district_name.upcase
    enrollment_symbol = input[district_name]
    if input.key?(district_name_upcase)
      @enrollments = Enrollment.new({:name => district_name_upcase, 
        :kindergarten_participation => date_hash_maker(enrollment_symbol),
        :high_school_graduation => date_hash_maker(enrollment_symbol)})
    else
      @enrollments = nil
    end
    @enrollments
  end

  def find_by_name(district_name) 
    
  end


end
