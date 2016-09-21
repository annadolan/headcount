require_relative 'district_repository'
require_relative 'district'
require_relative 'economic_profile'
require_relative 'shared_methods'
require_relative 'kindergarten'
require 'csv'
require 'pry'


class EconomicProfileRepository

  include SharedMethods
  include Kindergarten

  attr_reader :median_household_income, :children_in_poverty,
              :free_or_reduced_price_lunch, :title_i, :economic_repo,
              :districts

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
    districts = free_or_reduced_price_lunch.keys

    # add_to_economic_repo(districts)
econ_hash_maker(districts)

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
      economic_array
    end
    parse_testing(economic_array, key)


  end

  def add_to_economic_repo(districts)
    # @economic_repo = econ_hash_raw

    districts.map do |elem|
      econ_obj = EconomicProfile.new(elem)
      econ_obj.data = {:median_household_income => median_household_income[elem]},
                      {:children_in_poverty => children_in_poverty[elem]},
                      {:free_or_reduced_price_lunch => free_or_reduced_price_lunch[elem]},
                      {:title_i => title_i[elem]}
      elem = elem.upcase
      @economic_repo[elem] = econ_obj
    end
    @economic_repo
  end

  def find_by_name(district_name)
    @economic_repo[district_name.upcase]
  end

   def econ_hash_maker(districts)
     collect_median =
     econ_hash = econ_hash_raw
     districts.each do |dist|
       collect_median = @median_household_income[dist].collect {|item| item.values}.flatten
       collect_children = @children_in_poverty[dist].collect {|item| item.values}.flatten
       collect_lunch = @free_or_reduced_price_lunch[dist].collect {|item| item.values}.flatten
       collect_title = @title_i[dist].collect {|item| item.values}.flatten

       econ_hash[:median_household_income] = {@median_household_income[dist] =>
       binding.pry
       econ_hash[:children_in_poverty]
       econ_hash[:free_or_reduced_price_lunch]
       econ_hash[:title_i]
       econ_hash[:name] = dist
     end

   end
  #   econ_hash[]
  def econ_hash_raw
    raw_hash = {
      :median_household_income => nil,
      :children_in_poverty => nil,
      :free_or_reduced_price_lunch => nil,
      :title_i => nil,
      :name => nil
    }
  end

end
