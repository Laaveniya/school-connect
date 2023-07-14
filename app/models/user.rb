# frozen_string_literal: true

class User < ApplicationRecord
  extend Devise::Models
  searchkick
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :adminships, dependent: :destroy
  has_many :schools_administered, through: :adminships, source: :school
  has_many :school_admins, through: :adminships, source: :user
  has_many :school_memberships, dependent: :destroy
  has_many :enrolled_schools, through: :school_memberships, source: :school
  has_many :students, through: :school_memberships, source: :user
  has_many :administered_students, through: :schools_administered, source: :students

  enum role: { admin: 0, school_admin: 1, student: 2 }

  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
end
