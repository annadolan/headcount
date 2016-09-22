module GradeAndTestData
  
  attr_accessor :final_hash
  
  def clean_subject(subject, race)
    ethnicities = get_ethnicity(subject)
    subject_array = ethnicities[race.to_s.capitalize]
    if subject_array.nil?
      subject_data = [[0.001],[0.001],[0.001],[0.001]]
    else
      subject_data = subject_array.map do |item|
        if item.values[0].class != Float
          item.values = 0
        else
          item.values
        end
      end
    end
    subject_data
  end

  def make_final_hash(years, math_array, reading_array, writing_array)
    new_array = years.zip(math_array.zip(reading_array, writing_array))
    final_hash = {}
    new_array.each do |item|
      
      final_hash[item[0]] = {:math => truncate_float(item[1][0][:math]),
                            :reading => truncate_float(item[1][1][:reading]),
                            :writing => truncate_float(item[1][2][:writing])
                            }
      end
    final_hash
  end

  def clean_grade(grade_to_clean)
    year_array = get_year(grade_to_clean)
    subject_array = get_subject(get_year(grade_to_clean))
    years = years(year_array)
    grouped = get_grouped(subject_array)
    math_array = grouped[:math]
    reading_array = grouped[:reading]
    writing_array = grouped[:writing]
    make_final_hash(years, math_array, reading_array, writing_array)
  end

  def get_year(grade_to_clean)
    year_array = []
    grade_to_clean.each do |elem|
      year_array << elem.values
    end
    year_array = year_array.flatten
    year_array.sort_by! {|hsh| hsh.keys }
  end
  
  def get_subject(year_array)
    subject_array = []
    year_array.each do |elem|
      subject_array << elem.values
    end
    subject_array = subject_array.flatten
  end

  def get_ethnicity(subject)
    ethnicity = []
    subject.each_with_index do |elem, i|
      ethnicity << subject[i].values[0].values
    end
    ethnicity.flatten!
    ethnicity.group_by {|item| item.keys[0]}
  end

  def get_grouped(subject_array)
    values_array = []
    subject_array.each do |elem|
      values_array << {elem.keys[0].downcase.to_sym => elem.values[0]}
    end
    grouped = values_array.group_by {|elem| elem.keys[0]}
  end

  def years(year_array)
    years = []
    year_array.each do |elem|
      years << elem.keys[0].to_i
    end
    years.uniq!
  end
  
  def truncate_float_for_analyst(num)
      truncated = (num.to_f*1000).floor/1000.0
  end
  
end