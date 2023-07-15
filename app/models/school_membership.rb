class SchoolMembership < ApplicationRecord
  belongs_to :user
  belongs_to :school

  scope :active, -> { where(active: true) }
end
