require_relative 'district_repository'
require_relative 'district'
require_relative 'economic_profile'
require_relative 'shared_methods'
require 'csv'
require 'pry'


class EconomicProfileRepository < EconomicProfile
  include SharedMethods
  attr_accessor :economic_repo
  attr_reader :income, :children,
              :lunch, :title_i,
              :districts, :econ_hash

  YEARS = [1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2004,
            2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012, 2013, 2014, 2015]

  def initialize
    @economic_repo = Hash.new
    @income = Hash.new
    @children = Hash.new
    @lunch = Hash.new
    @title_i = Hash.new
  end

  def load_data(input)
    path = input[:economic_profile]
    @income = load_economic_csv(path[:median_household_income],
                                :median_household_income)
    @children = load_economic_csv(path[:children_in_poverty],
                                :children_in_poverty)
    @lunch = load_economic_csv(path[:free_or_reduced_price_lunch],
                                :free_or_reduced_price_lunch)
    @title_i = load_economic_csv(path[:title_i], :title_i)
    districts = lunch.keys
    econ_hash_maker(districts)
  end

  def load_economic_csv(path, key)
    econ_array = []
    CSV.foreach(path, headers: true, header_converters: :symbol) do |r|
      if path.include?("Median")
        econ_array << ({r[:location] => {r[:timeframe] => r[:data].to_f }})
      elsif path.include?("School-aged")
        econ_array << ({r[:location] => {r[:timeframe] => r[:data].to_f }})
      elsif path.include?("Students qualifying")
        econ_array << ({r[:location] => {r[:timeframe] =>
          {r[:poverty_level] => r[:data].to_f }}})
      elsif path.include?("Title")
        econ_array << ({r[:location] => {r[:timeframe] => r[:data].to_f }})
      end
      econ_array
    end
    parse_testing(econ_array, key)
  end

  def new_enrollment_object(dist, econ_hash)
      dist = dist.upcase
      add_to_economic_repo(econ_hash, dist)
  end

  def add_to_economic_repo(econ_hash, dist)
    @economic_repo[dist] = EconomicProfile.new(econ_hash)
  end

  def find_by_name(district_name)
    @economic_repo[district_name.upcase]
  end

   def econ_hash_maker(districts)
     econ_hash = econ_hash_raw
     districts.each do |dist|

      if @income[dist].nil?
        collect_median = 0
      else
        temp_median = @income[dist].collect {|item| item.values}.flatten
        collect_median = {}
        temp_median.each do |entry|
         collect_median[[entry.keys[0][0..3].to_i,
                        entry.keys[0][-4..-1].to_i]] = entry.values[0]
        end
      end

      if @children[dist].nil?
        collect_children = 0
      else
        temp_children = @children[dist].collect {|item| item.values}.flatten
        collect_children = {}
        temp_children.each do |entry|
        collect_children[entry.keys[0].to_i] = entry.values[0].to_f
        end
      end

      if @lunch[dist].nil?
        collect_lunch = 0
      else
        temp_lunch = @lunch[dist].collect {|item| item.values}.flatten
        collect_lunch = percent_or_number_seperator(temp_lunch)
      end

      if @title_i[dist].nil?
          collect_title = 0
      else
        collect_title = {}
        temp_title = @title_i[dist].collect {|item| item.values}.flatten
        temp_title.each do |entry|
          collect_title[entry.keys[0].to_i] = entry.values[0].to_f
        end
      end


       econ_hash[:median_household_income] = collect_median
       econ_hash[:children_in_poverty] = collect_children
       econ_hash[:free_or_reduced_price_lunch] = collect_lunch
       econ_hash[:title_i] = collect_title
       econ_hash[:name] = dist

       new_enrollment_object(dist, econ_hash)

     end
   end

  def econ_hash_raw
    raw_hash = {
      :median_household_income => nil,
      :children_in_poverty => nil,
      :free_or_reduced_price_lunch => nil,
      :title_i => nil,
      :name => nil
    }
  end

  def percent_or_number_seperator(temp_lunch)
    perc = []
    number = []
    new_hash = {}
    temp_lunch.each do |row|

      if row.values[0].values[0].to_f >= 1
        number << [row.keys[0].to_i, row.values[0].values[0].to_i]
      elsif row.values[0].values[0].to_f < 1
        perc << [row.keys[0].to_i, truncate_float(row.values[0].values[0].to_f)]
      end
    end

    zipped = number.zip(perc)
    zipped.each do |row|
      if row[0].nil?
        row[0] = 0
      elsif row[1].nil?
        row[1] = 0
      end
    end
    zipped.each do |item|
      new_hash[item[0][0]] =
                    {:percentage => item[1][1].to_f, :total =>item[0][1].to_i}
    end
  new_hash
end


end
