require 'minitest/autorun'
require 'minitest/pride'
require './lib/shared_methods'
require 'pry'

class SharedMethodsTest < Minitest::Test
  include SharedMethods

  def test_loader_can_load_CSV_files
    assert_instance_of Hash, load_csv('./data/Kindergartners in full-day program.csv')
  end
  
  def test_loader_can_populate_a_hash
     assert_instance_of Hash, load_data({
      :enrollment => {
        :kindergarten => "./data/Kindergartners in full-day program.csv"
      }
    })
  end


end
