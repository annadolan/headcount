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


end
