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
    @data = data
  end


  def median_household_income_in_year(year)
    raise UnknownDataError unless YEARS.include?(year)
    income = []
    result = data[:median_household_income].map do |row|
      if is_year_between?(year, row) == true
        income << row[1].to_i
      else
        nil
      end
      income
    end
    result = income.reduce(:+) / income.count
  end
  
  def is_year_between?(year, row)
    if row[0].class == Array
      range = row[0]
    else
      range = row[0].split("-")
    end
    temp_range = range.map do |date|
      date.to_i
    end
    temp_range
    year.between?(temp_range[0], temp_range[1])
  end
    

  def median_household_income_average
    if data.class == Hash
      household_income_avg = data[:median_household_income].values
    else
      household_income_avg = data[0][:median_household_income].map do |row|
        row.values[0].values[0].to_i
      end
    end
    result = household_income_avg.reduce(:+) / household_income_avg.count
    result
  end
  
  def children_in_poverty_in_year(year)
    raise UnknownDataError unless YEARS.include?(year)
    percent = []
    result = data[:children_in_poverty].values[0]
  end
  
  def free_or_reduced_price_lunch_percentage_in_year(year)
    raise UnknownDataError unless YEARS.include?(year)
    percent = []
    result = data[:free_or_reduced_price_lunch].values[0][:percentage]
  end
  
  def free_or_reduced_price_lunch_number_in_year(year)
    raise UnknownDataError unless YEARS.include?(year)
    number = []
    result = data[:free_or_reduced_price_lunch].values[0][:total]
  end
  
  def title_i_in_year(year)
    raise UnknownDataError unless YEARS.include?(year)
    percent = []
    result = data[:title_i].values[0]
  end
  
  
  
end
