require_relative 'shared_methods'

class EnrollmentRepository
  
  include SharedMethods
  
  attr_reader :district
  
  def initialize
    @input = load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv"
      }
    })
    @district = nil
  end
  
  def find_by_name(district_name)
    @district = @input["#{district_name}"]
  end
  
end