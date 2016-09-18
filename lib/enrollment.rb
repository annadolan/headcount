require_relative 'enrollment_repository'
require_relative 'shared_methods'
require_relative 'kindergarten'
require 'pry'

class Enrollment

  include SharedMethods
  include Kindergarten

  attr_reader :information, :name

  def initialize(information)
    @information = information
    @name = information[:name]
  end
  
  def graduation_rate_by_year
    grad_rate_by_year = @information[:high_school_graduation]
  end
  
  def graduation_rate_in_year(year)
    if @information[:high_school_graduation].include?(year) == false
      grad_rate_in_year = nil
    else
      grad_rate_in_year = @information[:high_school_graduation][year]
    end
  end

end
