class Parcel < ApplicationRecord
  belongs_to :potager

  def size
    ['a', 'c'].include?(potager.orientation) ? potager.width : potager.length
  end

  # def north?
  #   potager.parcels.map(&:width).max == width
  #   # potager.parcels.map { |parcel| parcel.width }
  # end
end
