require_relative 'economic_profile_repository'
require_relative 'shared_methods'
require_relative 'kindergarten'
require_relative 'errors'
require 'pry'

class EconomicProfile

  include SharedMethods
  include Kindergarten

  attr_accessor :data

  YEARS = [1995, 1996, 1997, 1998, 1999, 2000, 2001, 2002, 2003, 2004,
          2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012, 2013, 2014, 2015]

  def initialize(data)
    @data = {}
  end


  def median_household_income_in_year(year)
    raise UnknownDataError unless YEARS.include?(year)
    nums_to_average = []
    result = data[0][:median_household_income].map do |row|
      if row.values[0].keys[0].to_s.include?(year.to_s)
        nums_to_average << row.values[0].values[0].to_i
      end
    end
    result = nums_to_average.reduce(:+) / nums_to_average.count
  end

  def median_household_income_average
    household_income_avg = data[0][:median_household_income].map do |row|
      row.values[0].values[0].to_i
    end
    result = household_income_avg.reduce(:+) / household_income_avg.count
    result
  end
  
  def children_in_poverty_in_year(year)
    raise UnknownDataError unless YEARS.include?(year)
    percent = []
    array_to_check = data[1][:children_in_poverty]
    result = array_to_check.map do |row|
      if row.values[0].keys[0].to_s.include?(year.to_s)
        percent << truncate_float(row.values[0].values[0].to_f)
    
      end
    end
    percent.sort! # this is because until we get the number/percent thing figured out, this should return
                  # the right answer. urhg urhg urhg
    final_answer = percent[0]
  end
  
  def free_or_reduced_price_lunch_percentage_in_year(year)
    raise UnknownDataError unless YEARS.include?(year)
    percent = []
    array_to_check = data[2][:free_or_reduced_price_lunch]
    result = array_to_check.map do |row|
      if row.values[0].keys[0].to_s.include?(year.to_s)          
        percent << truncate_float(row.values[0].values[0].values[0].to_f)
      end
  end
  percent.sort!
  final_answer = percent[0]
  end
  
  def free_or_reduced_price_lunch_number_in_year(year)
    raise UnknownDataError unless YEARS.include?(year)
    number = []
    array_to_check = data[2][:free_or_reduced_price_lunch]
    result = array_to_check.map do |row|
      if row.values[0].keys[0].to_s.include?(year.to_s)
        number << truncate_float(row.values[0].values[0].values[0].to_f)
      end
  end
  final_answer = number[0].to_i
  end
  
  def title_i_in_year(year)
    raise UnknownDataError unless YEARS.include?(year)
    percent = []
    array_to_check = data[3][:title_i]
    result = array_to_check.map do |row|
      if row.values[0].keys[0].to_s.include?(year.to_s)
        percent << truncate_float(row.values[0].values[0].to_f)
      end
  end
  percent.sort!
  final_answer = percent[0]
  end
  
  
  
end
