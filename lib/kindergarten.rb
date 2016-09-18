require 'csv'

module Kindergarten
  def kindergarten_participation_by_year
    information[:kindergarten_participation]
  end

  def date_hash_maker(input)
    unless input.nil?
      array = []
      input.each do |elem|
        array << [elem[:timeframe].to_i, truncate_float(elem[:data])]
      @enrollment = array.to_h
    end
  end
  end

  def kindergarten_participation_in_year(year)
    information[:kindergarten_participation][year].to_f
  end

  def truncate_float(num)
    (num.to_f*1000).floor/1000.0
  end
end
