class VegetablesParcel < ApplicationRecord
  belongs_to :parcel
  belongs_to :vegetable
end
