require_relative 'shared_methods'
require_relative 'enrollment'

class EnrollmentRepository

  include SharedMethods

  attr_reader :district

  def initialize
    @input = load_data
    binding.pry
    @district = nil
  end

  def load_data(path = {
    :enrollment => {
      :kindergarten => "./data/Kindergartners in full-day program.csv"
    }
  })

  load_into_hash(path)


  end

  def find_by_name(district_name)
    enrollment_data = @input[district_name]
    district = Enrollment.new({:name => district_name, :kindergarten_participation => enrollment_data})
  end

end
