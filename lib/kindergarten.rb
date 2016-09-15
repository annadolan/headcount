require 'csv'

module Kindergarten
  def kindergarten_participation_by_year
    enrollment
  end

  def date_hash_maker(input)
    unless input.nil?
      array = []
      input.each do |elem|
        array << [elem[:timeframe].to_i, truncate_float(elem[:data])] #create method to truncate
      end
      @enrollment = array.to_h
    end
  end

  def kindergarten_participation_in_year(year)
    enrollment[year].to_f
  end

  def enrollment_graduation_rate_by_year
  end

  def graduation_rate_in_year(year)
  end

  def truncate_float(num)
    (num.to_f*1000).floor/1000.0
  end
end
