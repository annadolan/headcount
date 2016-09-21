require_relative 'economic_profile_repository'
require_relative 'shared_methods'
require_relative 'kindergarten'
require_relative 'errors'
require 'pry'

class EconomicProfile

  include SharedMethods
  include Kindergarten

  attr_accessor :data

  YEARS = [2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012, 2013]

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

end
