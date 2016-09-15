require 'csv'

module SharedMethods
  attr_reader :organized_entries, :enrollment

  def load_csv(filename_path)
    @data = CSV.open filename_path, headers: true, header_converters: :symbol
  end

  def hash_populate(incoming_data)
    all_entries = {}
    temporary_array = incoming_data.map { |row| row.to_hash }
    @organized_entries = temporary_array.group_by { |location| location[:location].upcase }
    @organized_entries
  end

  def load_into_hash(initial_hash)
    items = initial_hash[:enrollment][:kindergarten]
    items2 = initial_hash[:enrollment][:high_school_graduation]
    kindergarten = hash_populate(load_csv(items))
    high_school_graduation = hash_populate(load_csv(items2))
    full_hash = {:kindergarten => kindergarten, :high_school_graduation => high_school_graduation}
  end

  def zip_time_and_data(input)
    time = @enrollment.group_by { |x| x[:timeframe] }
    data = @enrollment.group_by { |x| x[:data]}
    all_info = time.keys.zip(data.keys)
    @enrollment = all_info.to_h
  end

  def enrollment_generator(data)
    @enrollment = data
    zip_time_and_data
    @enrollment
  end

end
