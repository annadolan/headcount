require_relative 'economic_profile_repository'
require_relative 'shared_methods'
require_relative 'kindergarten'
require_relative 'errors'
require 'pry'

class EconomicProfile
  
  include SharedMethods
  include Kindergarten
  
  attr_accessor :name, :median_household_income, :children_in_poverty,
                :free_or_reduced_price_lunch, :title_i, :data
  
  def initialize(data)
    @name = name
    @median_household_income = {}
    @children_in_poverty = {}
    @free_or_reduced_price_lunch = {}
    @title_i = {}
    @data = {}
  end

  
  
  
  
  
end