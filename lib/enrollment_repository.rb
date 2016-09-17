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

  # def find_by_name(district_name)
  #   input = @organized_entries
  #   district_name_upcase = district_name.upcase
  #   enrollment_symbol = input[district_name]
  #   if input.key?(district_name_upcase)
  #     enrollments = Enrollment.new({:name => district_name_upcase, :kindergarten_participation => date_hash_maker(enrollment_symbol)})
  #   else
  #     enrollments = nil
  #   end
  #   enrollments
  # end



  def new_enrollment(all_enrollment)
    all_enrollment.map do |elem|
      enroll_obj = Enrollment.new(elem)
      enrollments[elem[:name]] = enroll_obj
    end
    binding.pry
  end


end
