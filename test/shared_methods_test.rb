require 'minitest/autorun'
require 'minitest/pride'
require './lib/shared_methods'
require 'pry'

class SharedMethodsTest < Minitest::Test
  include SharedMethods

  def test_loader_can_load_CSV_files
    assert_instance_of CSV, load_csv('./data/Kindergartners in full-day program.csv')
  end

  def test_loader_can_create_array
    assert_instance_of Array, turn_csv_into_array
  end

  def test_loader_can_

end
