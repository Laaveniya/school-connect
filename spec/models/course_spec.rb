# frozen_string_literal

require 'rails_helper'

RSpec.describe Course, type: :model do
  let(:course) { create(:course)}
  subject { create(:course) }
  context "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:start_date) }
    it { should validate_presence_of(:end_date) }
  end

  context "associations" do
    it { should have_many(:school_admins) }
    it { should belong_to(:school) }
  end

  it 'should have a name' do
    expect(course.name).to be_present
  end

  it 'should have a description' do
    expect(course.description).to be_present
  end

  it 'should have a start date' do
    expect(course.start_date).to be_present
  end

  it 'should have an end date' do
    expect(course.end_date).to be_present
  end

  it 'should be associated with a school' do
    expect(course.school).to be_present
  end

  it 'should have a status' do
    expect(course.status).to eq('draft')
  end

  it 'should define the status enum' do
    expect(course).to define_enum_for(:status).with_values(draft: 0, active: 1, archived: 2)
  end

  it 'should create a course with valid attributes' do
    course = create(:course, name: 'Introduction to Programming')

    expect(course.name).to eq('Introduction to Programming')
    expect(course.description).to be_present
    expect(course.start_date).to be_present
    expect(course.end_date).to be_present
    expect(course.school).to be_present
  end
end
