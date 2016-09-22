require_relative 'enrollment_repository'
require_relative 'shared_methods'
require 'pry'

class Enrollment
  attr_reader :information, :name, :grad_year
  include SharedMethods

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

  def kindergarten_participation_by_year
    information[:kindergarten_participation]
  end

  def kindergarten_participation_in_year(year)
    information[:kindergarten_participation][year].to_f
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
