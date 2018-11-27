class Potager < ApplicationRecord
  belongs_to :user
  has_many :parcels
  validates :length, presence: true
  validates :width, presence: true
  # validates :freezing, presence: true
  validates :orientation, presence: true
  validates :start_month, presence: true

  after_create :create_parcels

  def create_parcels
    number = ['a', 'c'].include?(orientation) ? length : width
    number.times do |i|
      Parcel.create(
        order_from_south: i + 1,
        potager: self
      )
    end
  end
end
