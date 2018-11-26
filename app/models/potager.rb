class Potager < ApplicationRecord
  belongs_to :user
  validates :length, presence: true
  validates :width, presence: true
  validates :freezing, presence: true
  validates :orientation, presence: true
  validates :start_month, presence: true
end
