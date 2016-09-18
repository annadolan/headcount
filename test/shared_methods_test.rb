require './test/test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './test/test_helper'
require './lib/shared_methods'
require 'pry'

class SharedMethodsTest < Minitest::Test
  include SharedMethods

  def test_loader_can_load_CSV_files
    assert_instance_of Array, load_csv('./data/Kindergartners in full-day program.csv', :kindergarten_participation)
  end


end
