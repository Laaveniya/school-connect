class School < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  has_many :adminships, dependent: :destroy
  has_many :school_admins, through: :adminships, source: :user
  has_many :school_memberships, dependent: :destroy
  has_many :students, through: :school_memberships, source: :user
  has_many :courses, dependent: :destroy
  has_many :course_batches, through: :courses

  validates_presence_of :name, :address
end
