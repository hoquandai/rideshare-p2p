class Passenger < ApplicationRecord
  has_many :trips

  validates :name, presence: true, length: { in: 2..250 }
  validates :phone_num, presence: true, :uniqueness => true

  def get_active_passengers
    return find_active_passengers
  end

  def get_rides_taken
    return find_rides_taken
  end

  def get_incomplete_trips
    return find_incomplete_trips
  end

  def get_rides
    return find_rides
  end

  def get_total_charged
    return calculate_total_charged.to_string_rounded
  end

  def has_in_progress_trip?
    return !has_only_completed_trips?
  end

  private

  def has_only_completed_trips?
    return self.trips.all? { |trip| trip.is_complete? }
  end

  def find_rides_taken
    return self.trips.where.not(rating: nil)
  end

  def find_incomplete_trips
    return self.trips.where(rating: nil)
  end

  def find_rides
    return self.trips
  end

  def calculate_total_charged
    trips = self.get_rides_taken
    return trips.inject(0.0) { |sum, trip| sum + trip.cost_usd }
  end

  def find_active_passengers
    return self.passengers.where(is_deactivated: false)
  end

end
