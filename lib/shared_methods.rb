require 'csv'

module SharedMethods
  attr_reader :organized_entries, :enrollment

  def load_csv(path, key)
    enroll_array = []
    CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
      enroll_array << ({:name => row[:location].upcase,
                        row[:timeframe].to_i => row[:data].to_f})
    end
    parse(enroll_array, key)
  end

   def parse(enroll_array, key)
     temp_array = enroll_array.group_by { |item| item.values.first }.map{|_, second| second.reduce(:merge)}
     parse = temp_array.reduce({}) do |result, item|
      temp_array.map do |item|
      {:name => item.values_at(:name).join, key => item}
      end
    end
    delete_extra_name(parse, key)
   end

   def parse_testing(tests_array, key)
    parse = tests_array.group_by {|item| item.keys[0]}
    parse
  end

   def delete_extra_name(parse, key)
     final_enrollment = parse.map do |elem|
       elem[key].delete(:name)
       elem
     end
   end

   def zip_arrays(kindergarten_array, hs_array)
     all_enrollment = kindergarten_array.zip(hs_array).map do |kinder_array|
       kinder_array.reduce(&:merge)

     end
     new_enrollment(all_enrollment)
   end


end
