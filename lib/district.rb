require_relative 'district_repository'
require_relative 'shared_methods'

class District
  
  include SharedMethods
  
  attr_reader :name
  
  def initialize(district_name)
    @name = district_name[:name]
  end
  
  
end