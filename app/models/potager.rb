class Potager < ApplicationRecord
  belongs_to :user, optional: true
  has_many :parcels
  has_many :choices
  has_many :vegetables, through: :choices

  validates :length, presence: true, if: :active_or_dimension?
  validates :width, presence: true, if: :active_or_dimension?
  # validates :freezing, inclusion: { in: [true, false] }
  validates :orientation, presence: true, if: :active_or_orientation?
  validates :start_month, presence: true, if: :active_or_start_month?

  accepts_nested_attributes_for :choices

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

  def active?
    status == 'active'
  end

  def active_or_dimension?
    status.include?('def_dimension') || active?
  end

  def active_or_orientation?
    status.include?('def_orientation') || active?
  end

  def active_or_start_month?
    status.include?('def_start_month') || active?
  end
end
