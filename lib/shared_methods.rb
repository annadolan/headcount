require 'csv'

module SharedMethods

  def load_csv(filename_path)
    @data = CSV.open filename_path, headers: true, header_converters: :symbol
  end
<<<<<<< HEAD
  
  def hash_populate(incoming_data)
    @data_hash = {}
    output = incoming_data.each do |row|
      
      location_row = row[:location]
      timeframe_row = row[:timeframe]
      data_row = row[:data]
      
      @data_hash[location_row]  =
                      {"timeframe"    => timeframe_row,
                        "data"       => data_row}
    end
    @data_hash
  end
  
  def load_data(initial_hash)
    items = initial_hash[:enrollment][:kindergarten]
    hash_populate(load_csv(items))
=======

  def hash_populate
    data_hash = {}
    @data.each_with_index do |row, i|
    location = row[:location]
    timeframe = row[:timeframe]
    dataformat = row[:dataformat]
    data = row[:data]
    data_hash[location]  =
                    {"timeframe"    => timeframe,
                    "data"       => data}
                  end
    data_hash
  end

  def load_data(enrollment_hash)
    path = enrollment_hash[:enrollment][:kindergarten]
    load_csv(path)
>>>>>>> 2ecac27835c8a95a46cbbe0aa0942dfcec922058
  end

end
