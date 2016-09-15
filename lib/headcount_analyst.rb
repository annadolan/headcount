require_relative 'district_repository'

class HeadcountAnalyst
  attr_accessor :dist1, :dist2
  def initialize(new_repo)
    @new_repo = new_repo
  end

  def kindergarten_participation_rate_variation(district1, district2)
    dist1 = @new_repo.find_by_name(district1)
    dist2 = @new_repo.find_by_name(district2)
  end

  def kindergarten_participation_rate_variation_trend(district1, district2)
  end
end
