require 'csv'
require_relative 'shared_methods'
require 'pry'

class DistrictRepository

  include SharedMethods

  attr_reader :district, :data, :data_hash, :input, :name

  def initialize
    @input = load_data
    @district = nil
  end

  def load_data(path = {
    :enrollment => {
      :kindergarten => "./data/Kindergartners in full-day program.csv"
    }
  })

  load_into_hash(path)
<<<<<<< HEAD
  
=======


>>>>>>> 7746414502957141a7ec844281623414123b929e
  end


  def find_by_name(district_name)
    district_hash = @input.select { |k, v| k == district_name.upcase}
    @district = []
    district_hash.each do |k,v|
      @district << {:name => k}
    end
  end

  def find_all_matching(district_name_fragment)
    district_hash = @input.select { |k, v| k.include?(district_name_fragment.upcase)}
    @district = []
    district_hash.each do |k,v|
      @district << {:name => k}
    end

  end

end
