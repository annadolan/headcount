require 'pry'
require_relative 'shared_methods'
require_relative 'kindergarten'

class StatewideTestRepository
  include SharedMethods
  include Kindergarten
  attr_accessor :statewide_repo

  def initialize
    @statewide_repo = {}
  end

  def load_statewide_csv(path, key)
    enroll_array = []
    CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
      enroll_array << ({row[:timeframe] => row[:score], row[:timeframe].to_i => row[:data].to_f})
    end
    parse(enroll_array, key)
  end

  def load_data(input)
    paths = input.values[0]
    statewide_repo = paths.each do |k, v|
      load_statewide_csv(v, k)
    end

    # if input[:enrollment][:high_school_graduation].nil?
    #   kindergarten_array = load_csv(path, :kindergarten_participation)
    #   new_enrollment(kindergarten_array)
    # else
    #   path2 = input[:enrollment][:high_school_graduation]
    #   kindergarten_array = load_csv(path, :kindergarten_participation)
    #   hs_array = load_csv(path2, :high_school_graduation)
    #   zip_arrays(kindergarten_array, hs_array)
    # end
  end

end
