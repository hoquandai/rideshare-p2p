class Driver < ApplicationRecord
  has_many :trips

  validates :name, presence: true
  validates :vin, presence: true

  TRIP_FEE = 1.65

  def get_completed_trips
   return find_completed_trips
  end

  #
  def get_average_rating
    return get_completed_trips.empty? ? "--" : calculate_average_rating.to_string_rounded
  end

  def get_total_earnings
    return calculate_total_earning.to_string_rounded
  end

  def get_earned_amount(cost)
    raise ArgumentError.new("Invalid cost") if !cost.is_a?(Float)
    return get_earning_after_fee(cost).to_string_rounded
  end

  def get_status
    return is_available ? "Available" : "Unavailable"
  end

  def has_in_progress_trip?
    return !has_only_completed_trips?
  end

  private

  def has_only_completed_trips?
    return self.trips.all? { |trip| trip.is_complete? }
  end

  def find_completed_trips
    return self.trips.select { |trip| trip.is_complete? }
  end

  def calculate_average_rating
    completed_trips = get_completed_trips
    return completed_trips.inject(0.0) { |sum, trip| sum + trip.rating
      } / completed_trips.size
  end

  def calculate_total_earning
    return get_completed_trips.inject(0.0) { |sum, trip| sum +
      get_earning_after_fee(trip.cost_usd) }
  end

  def get_earning_after_fee(cost)
    return cost < TRIP_FEE ? 0.0 : (cost - TRIP_FEE) * 0.8
  end

end

class Float
  def to_string_rounded
    '%.2f' % self
  end
end
