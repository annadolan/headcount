require 'csv'
require './lib/shared_methods'
require 'pry'
class DistrictRepository
  include SharedMethods
  
  attr_reader :district, :data

  def initialize
    @data = load_data("./data/Kindergartners in full-day program.csv")
    @district = nil
  end

  def find_by_name(district_name)
    @district = @data["#{district_name}"]
  end

  def find_all_matching(district_name_fragment)
  
  end

end
