require 'csv'
require_relative 'shared_methods'
require 'pry'

class DistrictRepository

  include SharedMethods

  attr_reader :district, :data, :data_hash

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
    district_hash = @input.select { |k, v| k.include?(district_name_fragment.upcase)}
    @district = []
    district_hash.each do |k,v|
      @district << {:name => k}
    end
  end

end
