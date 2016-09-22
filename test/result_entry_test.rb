require './test/test_helper'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/result_entry'
require './lib/district_repository'
require 'pry'

class ResultEntryTest < Minitest::Test
  
  def test_result_entry_is_a_simple_hash_holder
    re = ResultEntry.new(data)
    assert_instance_of Hash, re.data
  end
  
end