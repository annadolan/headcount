require_relative 'shared_methods'
require_relative 'enrollment_repository'
require_relative 'enrollment'
require_relative 'district'
require_relative 'statewide_test_repository'
require_relative 'economic_profile_repository'
require 'csv'
require 'pry'

class DistrictRepository
  include SharedMethods
  attr_reader :districts, :enrollment_repo, :found_result, :statewide_test_repo,
              :economic_repo

  def initialize
    @economic_repo = EconomicProfileRepository.new
    @statewide_test_repo = StatewideTestRepository.new
    @enrollment_repo = EnrollmentRepository.new
    @districts = {}
  end

   def load_data(input)
    enrollment_repo.load_data(input)
    if input.include?(:statewide_testing)
      statewide_test_repo.load_data(input)
    elsif input.include?(:economic_profile)
      economic_repo.load_data(input)
    else 
      nil  
    end
     create_districts
   end

   def create_districts
    enrollment_repo.enrollments.keys.each do |elem|
      data = @enrollment_repo.find_by_name(elem)
      statewide = @statewide_test_repo.find_by_name(elem)
      economic = @economic_repo.find_by_name(elem)
      districts[elem] = District.new({:name => elem},
                                      {:information => data},
                                      {:statewide => statewide},
                                      {:economic => economic})
    end
  end

  def find_by_name(district_name)
    @districts[district_name.upcase]
  end

  def find_all_matching(district_fragment)
    input = @districts
    district_hash = input.select { |k, v| k.include?(district_fragment.upcase)}
    found_result = []
    found_result << district_hash.keys
    found_result.flatten
  end
end
