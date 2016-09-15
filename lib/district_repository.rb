require 'csv'
require_relative 'shared_methods'
require_relative 'enrollment_repository'
require_relative 'district'
require_relative 'kindergarten'
require 'pry'

class DistrictRepository
  include SharedMethods
  include Kindergarten

  attr_reader :district

  def initialize
    @district = []
    @enrollment_repository = EnrollmentRepository.new
  end

  def load_data(path)
    load_into_hash(path)
    @enrollment_repository.load_data(path)
  end

  def find_by_name(district_name)
    input = @organized_entries
    district_name_upcase = district_name.upcase
    enrollment_symbol = input[district_name_upcase]
    hash_entry = date_hash_maker(enrollment_symbol)
    if input.key?(district_name_upcase)
      district = District.new({:name => district_name_upcase, :kindergarten_participation => hash_entry})
    else
      district = nil
    end
  end

  def find_all_matching(district_name_fragment)
    input = @organized_entries
    district_hash = input.select { |k, v| k.include?(district_name_fragment.upcase)}
    district_hash.each do |k,v|
      @district << {:name => k}
    end
  end
end
