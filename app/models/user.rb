# frozen_string_literal: true

class User < ApplicationRecord
  extend Devise::Models
  searchkick
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: { admin: "Admin", school_admin: "School Admin", student: "Student" }

  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }

  def search_data
    {
      name: name,
      email: email
    }
  end
end
