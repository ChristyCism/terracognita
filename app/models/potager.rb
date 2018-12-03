class Potager < ApplicationRecord
  belongs_to :user, optional: true
  has_many :parcels
  has_many :choices
  has_many :vegetables, through: :choices
  validates :length, presence: true, :if => :active_or_dimension?
  validates :width, presence: true, :if => :active_or_dimension?
  validates :orientation, presence: true, :if => :active_or_orientation?
  # validates :freezing, presence: true
  validates :start_month, presence: true, :if => :active_or_start_month?

  accepts_nested_attributes_for :choices

  def create_parcels
    number = ['a', 'c'].include?(orientation) ? length : width
    number.times do |i|
      Parcel.create(
        order_from_south: i + 1,
        potager: self
      )
    end
    return number
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
