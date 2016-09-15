require 'csv'

module Kindergarten
  def kindergarten_participation_by_year
    enrollment
  end

  def date_hash_maker(input)
    unless input.nil?
      array = []
      input.each do |elem|
        array << [elem[:timeframe].to_i, (elem[:data].to_f*1000).floor/1000.0]
      end
      @enrollment = array.to_h
    end
  end

  def kindergarten_participation_in_year(year)
    enrollment[year].to_f
  end
end
