require 'csv'
require_relative 'shared_methods'
require 'pry'

class DistrictRepository
  include SharedMethods
  attr_reader :district, :data, :data_hash, :name

  def initialize
    @district = []
  end

  def load_data(path)
    load_into_hash(path)
  end

  def find_by_name(district_name)
    input = @organized_entries
    district_name = district_name.upcase
    if input.key?(district_name)
      district = District.new({:name => district_name})
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
