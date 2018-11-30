class Choice < ApplicationRecord
  belongs_to :potager
  belongs_to :vegetable

  def vegetablesParcels
    vegetables_selected = []
    vegetables_selected / number
  end

end
