# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  subject { create(:user) }
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should validate_presence_of(:password) }
    it { should validate_length_of(:password).is_at_least(6) }
  end

  describe "association" do
    it { should have_many(:adminships) }
    it { should have_many(:schools_administered).through(:adminships) }
    it { should have_many(:school_memberships) }
    it { should have_many(:students).through(:school_memberships) }
    it { should have_many(:school_admins).through(:adminships) }
    it { should have_many(:administered_students).through(:schools_administered) }
  end

  describe "enums" do
    it { should define_enum_for(:role).with_values(admin: 0, school_admin: 1, student: 2) }
  end

  describe "Devise modules" do
    it { should have_db_column(:encrypted_password).of_type(:string) }
    it { should have_db_column(:reset_password_token).of_type(:string) }
    it { should have_db_column(:reset_password_sent_at).of_type(:datetime) }
    it { should have_db_column(:remember_created_at).of_type(:datetime) }
  end
end

