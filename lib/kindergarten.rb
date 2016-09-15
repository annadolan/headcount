require 'csv'

module Kindergarten
  
  include SharedMethods
  
  def kindergarten_participation_by_year
    enrollment
  end

  def kindergarten_participation_in_year(year)    
    # if enrollment.none? { |word| word.include?(:timeframe) }
    #     enrollment["#{year}"].to_f
    # else
      enrollment["#{year}"].to_f
      
      
      # participation = enrollment.select { |i| i[:timeframe] == "#{year}" }
    
      # participation.map do |row|
      #   timeframe_row = row[:timeframe]
      #   data_row = row[:data]
      #   @results_hash = {timeframe_row => data_row}
      # end  
      # @results_hash["#{year}"].to_f
    # end
  end
  
  def date_hash_maker(input)
    unless input.nil?
       input.map do |row|
        timeframe_row = row[:timeframe]
        data_row = row[:data]
        @results_hash = {timeframe_row => data_row}
      end
      @results_hash.to_h
    end
  end
      
  
  
  
  
end