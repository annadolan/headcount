require 'csv'

module SharedMethods

  def load_csv(filename_path)
    @data = CSV.open filename_path, headers: true, header_converters: :symbol
    hash_populate
  end

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
  end

end
