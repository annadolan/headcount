require 'minitest/autorun'
require 'minitest/pride'
require './lib/enrollment_repository'
require 'pry'

class EnrollmentRepositoryTest < Minitest::Test

def test_er_can_find_a_district_by_name
  
  er = EnrollmentRepository.new
  er.find_by_name("ACADEMY 20")
  assert_equal "0.49022", er.district["data"]

end



end