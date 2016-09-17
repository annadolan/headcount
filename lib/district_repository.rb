require 'csv'
require_relative 'shared_methods'
require_relative 'enrollment_repository'
require_relative 'enrollment'
require_relative 'kindergarten'
require 'pry'

class DistrictRepository
  include SharedMethods
  include Kindergarten

  attr_reader :district, :collection

  def initialize
    @collection = {}
    # @district = []
    # @enrollment_repository = EnrollmentRepository.new
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

  def zip_arrays(kindergarten_array, hs_array)
    all_enrollment = kindergarten_array.zip(hs_array).map do |kindergarten_array|
      kindergarten_array.reduce(&:merge)
    end
    new_enrollment(all_enrollment)
  end

  def new_enrollment(all_enrollment)
    all_enrollment.map do |elem|
      enroll_obj = Enrollment.new(elem)
      collection[elem] = enroll_obj
    end
  end

  def find_by_name(district_name)
    if district_name.nil?
      "Entry error."
    else
    collection[district_name.upcase]
    end
  end

  def find_all_matching(district_fragment)
    matching = []
    district.find_all do |district_name, district|
      matching << district if district_name.include?(district_fragment.upcase)
    end
    matching
  end

dr = DistrictRepository.new
dr.load_data({
  :enrollment => {
    :kindergarten => "./data/Kindergartners in full-day program.csv",
    :high_school_graduation => "./data/High school graduation rates.csv"
  }
})
end