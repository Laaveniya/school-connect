# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Enrollment do
  subject { create(:enrollment) }

  describe "association" do
    it { should belong_to(:course_batch) }
    it { should belong_to(:student) }
    it { should belong_to(:approver).optional }
  end

  describe 'enums' do
    it { should define_enum_for(:status).with_values(requested: 0, approved: 1, dropped: 2, denied: 3) }
  end
end
