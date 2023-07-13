# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  subject { create(:adminship) }

  describe "association" do
    it { should belong_to(:user) }
    it { should belong_to(:school) }
  end
end


