require 'csv'
require 'pry'
class DistrictRepository

  def load_data(contents_to_load = {})
    data = CSV.open contents_to_load
  end

  def find_by_name
  end

  def find_all_matching
  end

end
