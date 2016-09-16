require 'csv'

module SharedMethods
  attr_reader :organized_entries_kg, :organized_entries_hs, :enrollment
  
  def load_csv(filename_path)
    csv_input = CSV.open filename_path, headers: true, header_converters: :symbol
  end
  
  def zip_time_and_data(input)
    time = enrollment.group_by { |x| x[:timeframe] }
    data = enrollment.group_by { |x| x[:data] }
    all_info = time.keys.zip(data.keys)
    enrollment = all_info.to_h
  end

  def enrollment_generator(data)
    enrollment = data
    zip_time_and_data
    enrollment
  end

end
