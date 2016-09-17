require 'csv'
require_relative 'shared_methods'
require_relative 'enrollment_repository'
require_relative 'enrollment'
require_relative 'kindergarten'
require 'pry'

class DistrictRepository
  include SharedMethods
  include Kindergarten

  attr_reader :districts, :enrollment_repo

  def initialize
    @collection = {}
    @enrollment_repo = EnrollmentRepository.new
    @districts = districts
    # @district = []

  end

   def load_data(input)
     enrollment_repo.load_data(input)
     create_districts
     binding.pry
   end

   def create_districts
      enrollment_repo.enrollments.keys.each do |elem|
        districts[elem] = District.new({:name => elem})
      end
   end
  #   path = input[:enrollment][:kindergarten]
  #   if input[:enrollment][:high_school_graduation].nil?
  #     kindergarten_array = load_csv(path, :kindergarten_participation)
  #     new_enrollment(kindergarten_array)
  #   else
  #     path2 = input[:enrollment][:high_school_graduation]
  #     kindergarten_array = load_csv(path, :kindergarten_participation)
  #     hs_array = load_csv(path2, :high_school_graduation)
  #     zip_arrays(kindergarten_array, hs_array)
  #   end
  # end



  def find_by_name(district_name)
    collection[district_name]
    # input = @organized_entries
    # district_name_upcase = district_name.upcase
    # enrollment_symbol = input[district_name_upcase]
    # hash_entry = date_hash_maker(enrollment_symbol)
    # if input.key?(district_name_upcase)
    #   district = District.new({:name => district_name_upcase, :kindergarten_participation => hash_entry})
    # else
    #   district = nil
    # end
  end

  # def find_all_matching(district_name_fragment)
  #   input = @organized_entries
  #   district_hash = input.select { |k, v| k.include?(district_name_fragment.upcase)}
  #   district_hash.each do |k,v|
  #     @district << {:name => k}
  #   end
  # end
end

dr = DistrictRepository.new
dr.load_data({
  :enrollment => {
    :kindergarten => "./data/Kindergartners in full-day program.csv",
    :high_school_graduation => "./data/High school graduation rates.csv"
  }
})
