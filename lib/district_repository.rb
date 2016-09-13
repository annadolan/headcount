require 'csv'
require_relative 'shared_methods'
require 'pry'

class DistrictRepository

  include SharedMethods
<<<<<<< HEAD
  
  attr_reader :district, :data, :data_hash
=======

  attr_reader :district, :data
>>>>>>> 2ecac27835c8a95a46cbbe0aa0942dfcec922058

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

  def find_all_matching(district_name_fragment)
    @district = @input.keys.select { |k| k.include?(district_name_fragment.upcase)}

  end

end
