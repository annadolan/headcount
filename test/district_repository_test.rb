require 'minitest/autorun'
require 'minitest/pride'
require './lib/district_repository'
require 'pry'

class DistrictRepositoryTest < Minitest::Test

  def test_can_load_a_csv
    dr = DistrictRepository.new

    assert_instance_of CSV, dr.load_data
  end
end
