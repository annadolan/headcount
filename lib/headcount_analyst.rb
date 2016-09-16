require_relative 'district_repository'
require_relative 'enrollment'
require_relative 'kindergarten'

class HeadcountAnalyst
  include Kindergarten
  attr_accessor :dist1, :dist2
  
  def initialize(district_repo)
    @district = district_repo
  end

  def district_average(district)
    dist_values_kg = district.enrollment.enrollment_kg.values
    dist_total = dist_values_kg.reduce(:+)
    dist_avg = dist_total/dist_values_kg.count
  end

  def kindergarten_participation_rate_variation(district1, district2)
    if district2.class == Hash
      district2 = district2.values[0]
    end
    @dist1 = @district.find_by_name(district1)
    @dist2 = @district.find_by_name(district2)
    variation = district_average(@dist1)/district_average(@dist2)
    variation_truncated = truncate_float(variation)
  end

  def kindergarten_participation_rate_variation_trend(district1, district2)
    if district2.class == Hash
      district2 = district2.values[0]
    end
    @dist1 = @district.find_by_name(district1)
    @dist2 = @district.find_by_name(district2)
    years_array = @district.enrollment_repository.enrollments.enrollment_kg.zip(@district.enrollment_repository.enrollments.enrollment_kg)
    year_avg_array = []
    years_array.to_h.each do |k, v|
      year_avg_array << [k[0], truncate_float(k[1]/v[1])]
    end
    year_hash = year_avg_array.to_h
  end
end
