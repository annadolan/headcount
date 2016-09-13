require 'csv'

module SharedMethods

  def load_csv(filename_path)
   @data = CSV.open filename_path, headers: true, header_converters: :symbol
  end

  def turn_csv_into_array(filename_path)
    load_csv(filename_path)
    data_to_parse = @data.map { |info| info }
  end

  def hash_populate(filename_path)
    load_csv(filename_path)
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
  
  def load_data(filename_path)
    hash_populate(filename_path)
  end

end
