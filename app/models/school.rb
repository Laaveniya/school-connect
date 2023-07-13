class School < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  has_many :adminships, dependent: :destroy
  has_many :admins, through: :adminships, source: :user

  validates_presence_of :name, :address
end
