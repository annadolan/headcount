require 'csv'
require_relative 'shared_methods'
require_relative 'enrollment_repository'
require_relative 'enrollment'
require_relative 'kindergarten'
require_relative 'district'
require 'pry'

class DistrictRepository
  include SharedMethods
  include Kindergarten

  attr_reader :districts, :enrollment_repo, :found_result

  def initialize
    @enrollment_repo = EnrollmentRepository.new
    @districts = {}
  end

   def load_data(input)
     enrollment_repo.load_data(input)
     create_districts
   end

   def create_districts
    enrollment_repo.enrollments.keys.each do |elem|
      information = @enrollment_repo.find_by_name(elem)
      districts[elem] = District.new({:name => elem}, {:information => information })
    end
  end

  def find_by_name(district_name)
    @districts[district_name.upcase]
  end

  def find_all_matching(district_name_fragment)
    input = @districts
    district_hash = input.select { |k, v| k.include?(district_name_fragment.upcase)}
    found_result = []
    found_result << district_hash.keys
    found_result.flatten
  end
end
