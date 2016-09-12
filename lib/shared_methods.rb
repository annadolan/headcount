require 'csv'

module SharedMethods

  def load_csv(contents_to_load = {})
   @data = CSV.open contents_to_load, headers: true, header_converters: :symbol
  end

  def turn_csv_into_array(filename_path = "./data/Kindergartners in full-day program.csv")
    load_csv(filename_path)
    data_to_parse = @data.map { |info| info }
  end

  def hash_populate
    load_csv("./data/Kindergartners in full-day program.csv")
    data_hash = {}
    @data.each_with_index do |row, i|
    location = row[:location]
    timeframe = row[:timeframe]
    dataformat = row[:dataformat]
    data = row[:data]
    data_hash["location" => location]  =
                    {"timeframe"    => timeframe,
                    "dataformat" => dataformat,
                    "data"       => data}
                  end
    data_hash
  end


  def find_by_name(name = "")
  end

end
