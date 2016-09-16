require 'csv'

module SharedMethods
  attr_reader :organized_entries, :enrollment

  def load_csv(path, key)
    enroll_array = []
    CSV.foreach(path, headers: true, header_converters: :symbol) do |row|
      enroll_array << ({:name => row[:location].upcase, row[:timeframe].to_i => row[:data].to_f})
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

   def delete_extra_name(parse, key)
     final_enrollment = parse.map do |elem|
       elem[key].delete(:name)
       elem
     end
   end

  # def hash_populate(incoming_data)
  #   all_entries = {}
  #   temporary_array = incoming_data.map { |row| row.to_hash }
  #   @organized_entries = temporary_array.group_by { |location| location[:location].upcase }
  #   @organized_entries
  # end

  # def load_into_hash(initial_hash)
  #   items = initial_hash[:enrollment][:kindergarten]
  #   hash_populate(load_csv(items))
  # end





  # def zip_time_and_data(input)
  #   time = @enrollment.group_by { |x| x[:timeframe] }
  #   data = @enrollment.group_by { |x| x[:data]}
  #   all_info = time.keys.zip(data.keys)
  #   @enrollment = all_info.to_h
  # end

  # def enrollment_generator(data)
  #   @enrollment = data
  #   zip_time_and_data
  #   @enrollment
  # end

end
