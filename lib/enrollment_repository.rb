require_relative 'shared_methods'

class EnrollmentRepository
  
  include SharedMethods
  
  attr_reader :district
  
  def initialize
    @input = load_data
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
    @district = @input["#{district_name}"]
  end
  
end