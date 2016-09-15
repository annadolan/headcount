require 'csv'

module Kindergarten
        
  def kindergarten_participation_by_year
    enrollment
  end

  def kindergarten_participation_in_year(year)  
      enrollment[year].to_f
  end
  
  def date_hash_maker(input)
    unless input.nil?
      time_hash = input.group_by { |x| x[:timeframe].to_i }
      data_hash = input.group_by { |x| x[:data].to_f }
      all_info = time_hash.keys.zip(data_hash.keys)
      @enrollment = all_info.to_h
    end
  end  
end