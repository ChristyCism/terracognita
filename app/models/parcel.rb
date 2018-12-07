class Parcel < ApplicationRecord
  belongs_to :potager
  has_one :vegetables_parcel, dependent: :destroy

  scope :toto, ->(orientation) do
    direction = orientation.in?(["B", "C"]) ? :desc : :asc
    order(order_from_south: direction)
  end
end
