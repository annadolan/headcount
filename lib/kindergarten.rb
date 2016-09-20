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
      end
      @enrollment = array.to_h
    end
  end

  def kindergarten_participation_in_year(year)
    information[:kindergarten_participation][year].to_f
  end

  def truncate_float(num = 0)

    if (num.class == String || num == nil)
      truncated = 0.0
    else
      truncated = (num.to_f*1000).floor/1000.0
    end
      # zero_handler(truncated)
  end

  def zero_handler(num)
    if num == 0
      nil
    else
      num
    end
  end

end
