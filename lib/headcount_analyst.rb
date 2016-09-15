require_relative 'district_repository'
require_relative 'kindergarten'

class HeadcountAnalyst
  include Kindergarten
  attr_accessor :dist1, :dist2
  def initialize(new_repo)
    @new_repo = new_repo
  end

  def district_average(district)
    dist_values = district.enrollment.enrollment.values
    dist_total = dist_values.reduce(:+)
    dist_avg = dist_total/dist_values.count
  end

  def kindergarten_participation_rate_variation(district1, district2)
    if district2.class == Hash
      district2 = district2.values[0]
    end
    @dist1 = @new_repo.find_by_name(district1)
    @dist2 = @new_repo.find_by_name(district2)
    variation = district_average(@dist1)/district_average(@dist2)
    variation_truncated = truncate_float(variation)
  end

  def kindergarten_participation_rate_variation_trend(district1, district2)
    if district2.class == Hash
      district2 = district2.values[0]
    end
    @dist1 = @new_repo.find_by_name(district1)
    @dist2 = @new_repo.find_by_name(district2)
    years_array = @dist1.enrollment.enrollment.zip(@dist2.enrollment.enrollment)
  end
end
