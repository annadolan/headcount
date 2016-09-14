require_relative 'shared_methods'
require_relative 'enrollment'

class EnrollmentRepository
  include SharedMethods
  attr_reader :district

  def initialize
    @enrollments = nil
  end

  def load_data(path) 
    load_into_hash(path)
  end

  def find_by_name(district_name)
    input = @organized_entries
    if input.key?(district_name)
      enrollment_data = input[district_name]
      enrollments = Enrollment.new({:name => district_name, :kindergarten_participation => enrollment_data})
    else
      enrollments = nil
    end
  end
end
