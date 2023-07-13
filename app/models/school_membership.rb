class SchoolMembership < ApplicationRecord
  belongs_to :user
  belongs_to :school
end
