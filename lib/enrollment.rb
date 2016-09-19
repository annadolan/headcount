require_relative 'enrollment_repository'
require_relative 'shared_methods'
require_relative 'kindergarten'
require 'pry'

class Enrollment

  include SharedMethods
  include Kindergarten

  attr_reader :information, :name, :grad_year

  def initialize(information)
    @information = information
    @name = information[:name]
  end

  def graduation_rate_by_year
    grad_year = information[:high_school_graduation].reduce({}) do |year, data|
      year.merge!(data.first => truncate_float(data.last))
    end
    grad_year
  end

  def graduation_rate_in_year(year)
    if information[:high_school_graduation].include?(year) == false
      result = nil
    else
      grad_year = information[:high_school_graduation][year]
      result = truncate_float(grad_year)
    end
  end

end
