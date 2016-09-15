require_relative 'shared_methods'
require_relative 'enrollment'

class EnrollmentRepository
  include SharedMethods
  include Kindergarten
  
  attr_reader :district, :enrollments, :input

  def initialize
    @enrollments = nil
  end

  def load_data(path)
    load_into_hash(path)
  end

  def find_by_name(district_name)
    input = @organized_entries
    district_name_upcase = district_name.upcase
    enrollment_symbol = input[district_name]
    if input.key?(district_name_upcase)
      enrollments = Enrollment.new({:name => district_name_upcase, :kindergarten_participation => enrollment_symbol})
    else
      enrollments = nil
    end
    enrollments
  end


end
