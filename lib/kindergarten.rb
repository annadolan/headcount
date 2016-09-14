require 'csv'

module Kindergarten
  
  def kindergarten_participation_by_year
    enrollment_data
  end

  def kindergarten_participation_in_year(year)
    if enrollment_data.none? { |word| word.include?(:timeframe) }
        enrollment_data[year].to_f
    else
      participation = enrollment_data.select { |i| i[:timeframe] == "#{year}" }
      usable = participation.map do |row|
        timeframe_row = row[:timeframe]
        data_row = row[:data]
        @results_hash = {timeframe_row => data_row}
      end
      @results_hash["#{year}"].to_f
    end
  end
  
  
  
end