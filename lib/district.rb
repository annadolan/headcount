require_relative 'district_repository'
require_relative 'shared_methods'

class District
  attr_reader :name
  include SharedMethods
  
  attr_reader :name
  
  def initialize(district_input)
    @name = district_input[:name]
  end


end
