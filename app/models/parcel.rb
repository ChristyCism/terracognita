class Parcel < ApplicationRecord
  belongs_to :potager
  has_one :vegetables_parcel
end
