require 'csv'

module SharedMethods
  attr_reader :organized_entries, :enrollment

  def load_csv(path, key)
    enroll_array = []
    CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
      location = row[:location].upcase
      year = row[:timeframe].to_i
      data = row[:data].to_f
      enroll_array << ({:name => location, year => data})
    end
    parse(enroll_array, key)
  end

   def parse(enroll_array, key)
     temp_array = enroll_array.group_by { |item| item.values.first }
     fix_array = temp_array.map{|_, second| second.reduce(:merge)}
     parse = fix_array.reduce({}) do |result, item|
      fix_array.map do |item|
      {:name => item.values_at(:name).join, key => item}
      end
    end
    delete_extra_name(parse, key)
   end

   def delete_extra_name(parse, key)
     final_enrollment = parse.map do |elem|
       elem[key].delete(:name)
       elem
     end
   end

   def zip_arrays(kindergarten_array, hs_array)
     all_enrollment = kindergarten_array.zip(hs_array).map do |array|
       kindergarten_array.reduce(&:merge)

     end
     new_enrollment(all_enrollment)
   end
end
