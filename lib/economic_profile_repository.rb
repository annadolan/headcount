require_relative 'district_repository'
require_relative 'district'
require_relative 'shared_methods'
require_relative 'kindergarten'
require 'csv'
require 'pry'


class EconomicProfileRepository
  
  include SharedMethods
  include Kindergarten
  
  attr_reader :median_household_income, :children_in_poverty, 
              :free_or_reduced_price_lunch, :title_i, :economic_repo
  
  def initialize
    @economic_repo = {}
    @median_household_income = {}
    @children_in_poverty = {}
    @free_or_reduced_price_lunch = {}
    @title_i = {}
  end
  
  def load_data(input)
    path = input[:economic_profile]
    @median_household_income = load_economic_csv(path[:median_household_income], :median_household_income)
    @children_in_poverty = load_economic_csv(path[:children_in_poverty], :children_in_poverty)
    @free_or_reduced_price_lunch = load_economic_csv(path[:free_or_reduced_price_lunch], :free_or_reduced_price_lunch)
    @title_i = load_economic_csv(path[:title_i], :title_i)    
  end
  
  def load_economic_csv(path, key)
    economic_array = []
    CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
      if path.include?("Median")
        economic_array << ({row[:location] => {row[:timeframe] => row[:data].to_f }})
      elsif path.include?("School-aged")
        economic_array << ({row[:location] => {row[:timeframe] => row[:data].to_f }})
      elsif path.include?("Students qualifying")
        economic_array << ({row[:location] => {row[:timeframe] => {row[:poverty_level] => row[:data].to_f }}})
      elsif path.include?("Title")
        economic_array << ({row[:location] => {row[:timeframe] => row[:data].to_f }})
      end
    end
    economic_array
  end

  def add_to_economic_repo(keys)
    keys.map do |elem|
      econ_obj = EconomicProfile.new(elem)
      econ_obj.median_household_income = median_household_income[elem]
      econ_obj.children_in_poverty = children_in_poverty[elem]
      econ_obj.free_or_reduced_price_lunch = free_or_reduced_price_lunch[elem]
      econ_obj.title_i = title_i[elem]
      @economic_repo[elem] = econ_obj
    end
    @economic_repo
  end  
  
end