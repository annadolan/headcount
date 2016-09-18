require_relative 'district_repository'
require_relative 'kindergarten'

class HeadcountAnalyst
  include Kindergarten

  attr_reader :dist1, :dist2, :hs_dist1, :hs_dist2, :new_repo

  def initialize(new_repo)
    @new_repo = new_repo
  end

  def kg_district_average(district)
    dist_values = district.enrollment.information.values[1].values
    dist_total = dist_values.reduce(:+)
    dist_avg = dist_total/dist_values.count
  end
  
  def hs_district_average(district)
    dist_values = district.enrollment.information.values[1].values
    dist_total = dist_values.reduce(:+)
    dist_avg = dist_total/dist_values.count
  end

  def kindergarten_participation_rate_variation(district1, district2)
    if district2.class == Hash
      district2 = district2.values[0]
    end
    @dist1 = @new_repo.find_by_name(district1)
    @dist2 = @new_repo.find_by_name(district2)
    variation = kg_district_average(dist1)/kg_district_average(dist2)
    variation_truncated = truncate_float(variation)
  end

  def kindergarten_participation_rate_variation_trend(district1, district2)
    if district2.class == Hash
      district2 = district2.values[0]
    end
    @dist1 = @new_repo.find_by_name(district1)
    @dist2 = @new_repo.find_by_name(district2)
    first_district = dist1.enrollment.information[:kindergarten_participation]
    second_district = dist2.enrollment.information[:kindergarten_participation]
    years_array = first_district.zip(second_district)
    year_avg_array = []
    years_array.to_h.each do |k, v|
      year_avg_array << [k[0], truncate_float(k[1]/v[1])]
    end
    year_hash = year_avg_array.to_h
  end
  
  def high_school_graduation_rate_variation(hs_district1, hs_district2)
    if hs_district2.class == Hash
      hs_district2 = hs_district2.values[0]
    end
    @hs_dist1 = @new_repo.districts.find_by_name(hs_district1)
    @hs_dist2 = @new_repo.districts.find_by_name(hs_district2)
    variation = hs_district_average(hs_dist1)/hs_district_average(hs_dist2)
    variation_truncated = truncate_float(variation)
  end
  
  def kindergarten_participation_against_high_school_graduation(district)
    vari_kg = kindergarten_participation_rate_variation(district, 'COLORADO')
    vari_hs = high_school_graduation_rate_variation(district, 'COLORADO')
  end
  
end
