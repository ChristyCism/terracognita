class Potager < ApplicationRecord
  belongs_to :user
  has_many :parcels
  has_many :choices
  has_many :vegetables, through: :choices
  validates :length, presence: true
  validates :width, presence: true
  validates :freezing, inclusion: { in: [true, false] }
  validates :orientation, presence: true
  validates :start_month, presence: true

  accepts_nested_attributes_for :choices

  after_create :create_parcels

  def create_parcels
    number_of_parcels = ['a', 'c'].include?(orientation) ? length : width
    parcel_size = ['a', 'c'].include?(orientation) ? width : length
    number_of_parcels.times do |i|
      Parcel.create(
        order_from_south: i + 1,
        potager: self,
        size: parcel_size
      )
    end
  end
end
