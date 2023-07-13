# frozen_string_literal: true

require 'rails_helper'

RSpec.describe School, type: :model do
  subject { create(:school) }
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:address) }
  end

  describe "association" do
    it { should belong_to(:creator) }
    it { should have_many(:school_admins).through(:adminships)  }
    it { should have_many(:school_memberships) }
    it { should have_many(:adminships)}
    it { should have_many(:students)}
  end
end

