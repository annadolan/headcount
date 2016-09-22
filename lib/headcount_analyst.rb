require_relative 'district_repository'
require_relative 'statewide_test_repository'
require_relative 'statewide_test'
require_relative 'grade_and_test_data'
require_relative 'errors'
require_relative 'shared_methods'

class HeadcountAnalyst
  include SharedMethods
  include GradeAndTestData

  attr_accessor :dist1, :dist2, :truncated_variance, :results, :g_input,
                :s_input, :grade_to_clean, :blank_hash

  GRADES = [3, 8]

  def initialize(new_repo)
    @new_repo = new_repo
    @final_hash = final_hash
  end

  def top_statewide_test_year_over_year_growth(grade: g_input, subject: s_input)
    final_hash = {}
    testing_analysis_error_checker(grade)
    if grade == 3
      grade_to_clean = @new_repo.statewide_test_repo.third_grade
    elsif grade == 8
      grade_to_clean = @new_repo.statewide_test_repo.eighth_grade
    else
      nil
    end
    test_array = []
    grade_to_clean.values.each do |row|
      test_array << clean_grade(row)
    end
    
    keys = grade_to_clean.keys.reject! {|i| i == "Colorado"}
    hash_to_modify = keys.zip(test_array).reject {|i| i == nil}.to_h
    subject = :math
    blank_hash = {}
    keys.each do |key|
      max = hash_to_modify[key].keys.max
      min = hash_to_modify[key].keys.min
      first = (hash_to_modify[key][max][subject])
      second = (hash_to_modify[key][min][subject])
      if second.nil?
        second = 0
      end
      if first.nil?
        first = 0
      end
        subtracted_values = first - second
        blank_hash[key] = {subject => truncate_float_for_analyst(subtracted_values)}
        sorted_hash = blank_hash.sort_by {|k, v| v.values }
    result = [sorted_hash[0][0], sorted_hash[0][1].values[0].abs]
    end
  end

  def district_average(district)
    dist_values = district.enrollment.information.values[1].values
    dist_total = dist_values.reduce(:+)
    dist_avg = dist_total/dist_values.count
  end

  def hs_district_average(district)
    dist_vals = district.enrollment.information[:high_school_graduation].values
    dist_total = dist_vals.reduce(:+)
    dist_avg = dist_total/dist_vals.count
  end

  def high_school_graduation_rate_variation(district1, district2)
    if district2.class == Hash
      district2 = district2.values[0]
    end
    dist1 = @new_repo.find_by_name(district1)
    dist2 = @new_repo.find_by_name(district2)
    variation = hs_district_average(dist1)/hs_district_average(dist2)
    variation_truncated = truncate_float(variation)
  end

  def kindergarten_participation_rate_variation(district1, district2)
    if district2.class == Hash
      district2 = district2.values[0]
    end
    dist1 = @new_repo.find_by_name(district1)
    dist2 = @new_repo.find_by_name(district2)
    variation = district_average(dist1)/district_average(dist2)
    variation_truncated = truncate_float(variation)
  end

  def kindergarten_participation_rate_variation_trend(district1, district2)
    if district2.class == Hash
      district2 = district2.values[0]
    end
    dist1 = @new_repo.find_by_name(district1)
    dist2 = @new_repo.find_by_name(district2)
    first_to_zip = dist1.enrollment.information[:kindergarten_participation]
    second_to_zip = dist2.enrollment.information[:kindergarten_participation]
    years_array = first_to_zip.zip(second_to_zip)
    year_avg_array = []
    years_array.to_h.each do |k, v|
      year_avg_array << [k[0], truncate_float(k[1]/v[1])]
    end
    year_hash = year_avg_array.to_h
  end

  def kindergarten_participation_against_high_school_graduation(district)
    kg_vari = kindergarten_participation_rate_variation(district, "COLORADO")
    hs_vari = high_school_graduation_rate_variation(district, "COLORADO")
    if kg_vari.nil? || hs_vari.nil?
      variance = 0
    else
      variance = kg_vari / hs_vari
    end
    @truncated_variance = truncate_float(variance)
  end

  def kindergarten_participation_correlates_with_high_school_graduation(input)
    if input.values[0] == 'STATEWIDE'
      large_group_correlation_finder
    elsif input.keys[0] == :across
      small_group_correlation_finder(input)
    else
      kindergarten_participation_against_high_school_graduation(input.values[0])
      correlation_checker(truncated_variance)
    end
  end

  def large_group_correlation_finder
    districts_to_check = reject_all_state_data(@new_repo.districts)
    results = districts_to_check.map do |item|
      group_data = item[1].enrollment.information[:name]
      kindergarten_participation_against_high_school_graduation(group_data)
      correlation_checker(truncated_variance)
    end
    trues = results.count(true).to_f
    falses = results.count(false).to_f
    percent = trues/districts_to_check.count.to_f
    answer = percentage_checker(truncate_float(percent))
  end

  def small_group_correlation_finder(district)
    results = district.values[0].map do |item|
      input = @new_repo.districts[item]
      input_checker = input.enrollment.information[:name]
      kindergarten_participation_against_high_school_graduation(input_checker)
      correlation_checker(truncated_variance)
    end
    trues = results.count(true).to_f
    falses = results.count(false).to_f
    percent = trues/district.values.count.to_f
    answer = percentage_checker(truncate_float(percent))
  end


  def correlation_checker(truncated_variance)
    if truncated_variance.nil?
      false
    else
      if truncated_variance >= 0.6 && truncated_variance <= 1.5
        true
      else
        false
      end
    end
  end

  def percentage_checker(percent)
    if percent >= 0.7
      true
    else
      false
    end
  end

  def reject_all_state_data(districts)
    statewide_districts = districts.reject { |district| district == "COLORADO" }
  end

  def testing_analysis_error_checker(grade)
    if grade.nil?
      raise InsufficientInformationError
    elsif GRADES.include?(grade) == false
      raise UnknownDataError
      "#{grade} is not a known grade."
    end
  end

  # def hash_template
  #   hash = {:math=>nil, :reading=>nil, :writing=>nil}
  # end

end
