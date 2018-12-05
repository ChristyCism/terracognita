class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one :potager
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
