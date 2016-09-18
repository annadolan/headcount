require_relative 'district_repository'
require_relative 'kindergarten'

class HeadcountAnalyst
  include Kindergarten
  attr_accessor :dist1, :dist2, :truncated_variance
  def initialize(new_repo)
    @new_repo = new_repo
  end

  def district_average(district)
    dist_values = district.enrollment.information.values[1].values
    dist_total = dist_values.reduce(:+)
    dist_avg = dist_total/dist_values.count
  end
  
  def hs_district_average(district)
    dist_values = district.enrollment.information[:high_school_graduation].values
    dist_total = dist_values.reduce(:+)
    dist_avg = dist_total/dist_values.count
  end
  
  def high_school_graduation_rate_variation(district1, district2)
    if district2.class == Hash
      district2 = district2.values[0]
    end
    @dist1 = @new_repo.find_by_name(district1)
    @dist2 = @new_repo.find_by_name(district2)
    variation = hs_district_average(@dist1)/hs_district_average(@dist2)
    variation_truncated = truncate_float(variation)
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
    years_array = @dist1.enrollment.information[:kindergarten_participation].zip(@dist2.enrollment.information[:kindergarten_participation])
    year_avg_array = []
    years_array.to_h.each do |k, v|
      year_avg_array << [k[0], truncate_float(k[1]/v[1])]
    end
    year_hash = year_avg_array.to_h
  end
  
  def kindergarten_participation_against_high_school_graduation(district)
    kindergarten_variation = kindergarten_participation_rate_variation(district, "COLORADO")
    high_school_variation = high_school_graduation_rate_variation(district, "COLORADO")
    variance = kindergarten_variation / high_school_variation
    @truncated_variance = truncate_float(variance)
  end
  
  def kindergarten_participation_correlates_with_high_school_graduation(district)
    if district.values[0] == 'STATEWIDE'
      reject_all_state_data(districts)
      # some kind of loop to go through all districts and average results?
      # then run percentage_checker
    elsif district.values.count > 1 
      # do basically the same loop as above but over specified districts
      # then run percentage_checker
    else
      kindergarten_participation_against_high_school_graduation(district.values[0])
      correlation_checker(truncated_variance)
    end
  end
  
  def correlation_checker(truncated_variance)
    if truncated_variance >= 0.6 && truncated_variance <= 1.5
      true
    else
      false
    end
  end
  
  def percentage_checker(percent)
    if percent >= 0.7
      true
    else
      false
    end
  end
  
  def statewide_loop(statewide_districts)
    
    
    
  end
  
  def reject_all_state_data(districts)
    statewide_districts = districts.reject { |district| district == "COLORADO" }
  end 
  
  
  
end
