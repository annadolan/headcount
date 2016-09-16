require 'csv'

module SharedMethods
  attr_reader :organized_entries, :enrollment

  def load_csv(filename_path)
    csv_input = CSV.open filename_path, headers: true, header_converters: :symbol
  end

  def hash_populate(incoming_data)
    temporary_array = incoming_data.map { |row| row.to_h }
    organized_entries = temporary_array.group_by do |location| 
      location[:location].upcase
    end
    organized_entries
  end

  def load_into_hash_kindergarten(initial_hash)
    kindergarten = initial_hash[:enrollment][:kindergarten]
    hash_populate(load_csv(kindergarten))    
  end

  def load_into_hash_high_school(initial_hash)
    high_school = initial_hash[:enrollment][:high_school_graduation]
    hash_populate(load_csv(high_school))
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
