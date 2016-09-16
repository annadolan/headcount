require 'csv'
require_relative 'shared_methods'
require_relative 'enrollment_repository'
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
    load_into_hash_kindergarten(path)
    load_into_hash_high_school(path)
    @enrollment_repository.load_data(path)
  end

  def find_by_name(district_name)
    name_to_search = district_name.upcase
    if @organized_entries_kg[name_to_search].nil? && @organized_entries_hs[name_to_search].nil?
      nil
    else
      District.new(:name => name_to_search, :enrollment => @organized_entries_kg && @organized_entries_hs)
    end 
       
  end

  def find_all_matching(district_name_fragment)
  
  end
end

def hash_populate_kindergarten(incoming_data)
  temporary_array = incoming_data.map { |row| row.to_h }
  @organized_entries_kg = temporary_array.group_by do |location| 
    location[:location].upcase
  end
  @organized_entries_kg
end

def hash_populate_high_school(incoming_data)
  temporary_array = incoming_data.map { |row| row.to_h }
  @organized_entries_hs = temporary_array.group_by do |location| 
    location[:location].upcase
  end
  @organized_entries_hs
end

def load_into_hash_kindergarten(initial_hash)
  kindergarten = initial_hash[:enrollment][:kindergarten]
  hash_populate_kindergarten(load_csv(kindergarten))    
end

def load_into_hash_high_school(initial_hash)
  high_school = initial_hash[:enrollment][:high_school_graduation]
  hash_populate_high_school(load_csv(high_school))
end