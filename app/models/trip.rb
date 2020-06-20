class Trip < ApplicationRecord
  belongs_to :driver
  belongs_to :passenger

  validates :date, presence: true
  validates_inclusion_of :rating, in: (1..5), allow_nil: true
  validates :cost, presence: true, numericality: { only_integer: true }
  validates :driver_id, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :passenger_id, presence: true, numericality: { only_integer: true, greater_than: 0 }
  after_save :set_driver_is_available


  def cost_usd
    return (cost / 100.0).round(2)
  end

  def cost_in_dollars
    return cost / 100.0
  end

  def is_complete?
    return !rating.nil?
  end

  def get_rides
    return find_rides
  end

  private

  # This method ensures driver availability is based on trip status.
  def set_driver_is_available
    driver.update(is_available: false) if !is_complete?
  end

  def find_rides
    return self.trips
  end

end
