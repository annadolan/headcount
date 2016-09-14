require 'csv'

module SharedMethods

  def load_csv(filename_path)
    @data = CSV.open filename_path, headers: true, header_converters: :symbol
  end

  def hash_populate(incoming_data)
    all_entries = {}
    temporary_array = incoming_data.map { |row| row.to_hash }
    @organized_entries = temporary_array.group_by { |location| location[:location] }
    @organized_entries
  end

  def load_into_hash(initial_hash)
    items = initial_hash[:enrollment][:kindergarten]
    hash_populate(load_csv(items))
  end
end
