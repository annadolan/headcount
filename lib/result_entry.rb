require_relative 'district_repository'
require_relative 'grade_and_test_data'
require_relative 'result_set'
require_relative 'headcount_analyst'
require_relative 'errors'
require_relative 'shared_methods'

class ResultEntry
  attr_reader :data
  
  def initialize(data = {})
    @data = data
  end
  
  def free_and_reduced_price_lunch_rate
    if data[:free_and_reduced_price_lunch_rate].nil?
      nil
    else
      data[:free_and_reduced_price_lunch_rate]
    end
  end
  
  def children_in_poverty_rate
    if data[:children_in_poverty_rate].nil?
      nil
    else 
      data[:children_in_poverty_rate]
    end
  end
  
  def high_school_graduation_rate
    if data[:high_school_graduation_rate].nil?
      nil
    else ``
      data[:high_school_graduation_rate]
    end
  end
  
  def median_household_income
    if data[:median_household_income].nil?
      nil
    else 
      data[:median_household_income]
    end
  end
  
  
end