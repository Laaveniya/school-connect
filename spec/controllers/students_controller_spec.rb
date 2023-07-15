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
end

