# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StudentsController, type: :controller do
  describe 'GET #dashboard' do
    context 'when student is authorized' do
      let(:student) { create(:user, role: :student) }
      let(:school) { create(:school) }
      let!(:school_membership) { create(:school_membership, user: student, school: school) }
      let(:course) { create(:course, school: school) }
      let(:course_batch) { create(:course_batch, course: course) }
      let(:enrollments) { create(:enrollment, course_batch: course_batch) }

      before do
        sign_in(student)
      end

      it 'renders the dashboard template' do
        get :dashboard

        expect(response).to render_template(:dashboard)
      end

      it 'assigns the necessary instance variables' do
        get :dashboard
        expect(assigns(:student)).to eq(student)
        expect(assigns(:course_batches)).to eq(student.school.course_batches)
        expect(assigns(:classmates)).to eq(student.classmates)
        expect(assigns(:enrollments)).to eq(student.enrollments)
      end
    end

    context 'when student is not authorized' do
      let(:student) { create(:user, role: :student) }

      it 'redirects to unauthorized page' do
        get :dashboard
        expect(response).to redirect_to('/users/sign_in')
      end
    end
  end

  describe 'POST #enroll_course_batch' do
    let(:student) { create(:user, role: :student) }
    let(:school) { create(:school) }
    let(:course) { create(:course, school: school) }
    let(:course_batch) { create(:course_batch, course: course) }
    let!(:school_membership) { create(:school_membership, user: student, school: school) }
    let(:enrollment) { create(:enrollment, student: student, course_batch: course_batch) }

    before do
      sign_in(student)
    end

    context 'when enrollment is successful' do
      it 'redirects to the dashboard with a success notice' do
        post :enroll_course_batch, params: { course_batch_id: course_batch.id }

        expect(response).to redirect_to(dashboard_path)
        expect(flash[:notice]).to eq('Successfully enrolled in course.')
      end
    end

    context 'when enrollment is unsuccessful' do
      before do
        allow_any_instance_of(Enrollment).to receive(:save).and_return(false)
      end

      it 'redirects to the dashboard with an alert message' do
        post :enroll_course_batch, params: { course_batch_id: course_batch.id }

        expect(response).to redirect_to(dashboard_path)
        expect(flash[:alert]).to eq('Enrollment unsuccessful in course.')
      end
    end
  end
end

