require_relative 'economic_profile_repository'
require_relative 'shared_methods'
require_relative 'kindergarten'
require_relative 'errors'
require 'pry'

class EconomicProfile

  include SharedMethods
  include Kindergarten

  attr_accessor :data

  def initialize(data)
    @data = {}
  end






end
