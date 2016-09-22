require_relative 'shared_methods'
require_relative 'enrollment'

class EnrollmentRepository
  attr_reader :district, :enrollments, :input
  include SharedMethods

  def initialize
    @enrollments = {}
  end

  def load_data(input)
    path = input[:enrollment][:kindergarten]
    if input[:enrollment][:high_school_graduation].nil?
      kindergarten_array = load_csv(path, :kindergarten_participation)
      new_enrollment(kindergarten_array)
    else
      path2 = input[:enrollment][:high_school_graduation]
      kindergarten_array = load_csv(path, :kindergarten_participation)
      hs_array = load_csv(path2, :high_school_graduation)
      zip_arrays(kindergarten_array, hs_array)
    end
  end

  def find_by_name(district_name)
    @enrollments[district_name.upcase]
  end

  def new_enrollment(all_enrollment)
    all_enrollment.map do |elem|
      enroll_obj = Enrollment.new(elem)
      enrollments[elem[:name]] = enroll_obj
    end
    @enrollments
  end
end
