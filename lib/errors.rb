class UnknownDataError < IndexError
end

class UnknownRaceError < IndexError
end

class InsufficientInformationError < IndexError
  "A grade must be provided to answer this question."
end