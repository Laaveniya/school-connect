# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CoursesController, type: :controller do
  let(:user) { create(:admin_user) }
  let(:course) { create(:course) }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'returns a successful response' do
      get :index
      expect(response).to be_successful
    end

    it 'assigns all courses to @courses' do
      get :index
      expect(assigns(:courses)).to eq([course])
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    it 'returns a successful response' do
      get :show, params: { id: course.id }
      expect(response).to be_successful
    end

    it 'assigns the requested course to @course' do
      get :show, params: { id: course.id }
      expect(assigns(:course)).to eq(course)
    end

    it 'renders the show template' do
      get :show, params: { id: course.id }
      expect(response).to render_template(:show)
    end
  end

  describe 'GET #new' do
    it 'returns a successful response' do
      get :new
      expect(response).to be_successful
    end

    it 'assigns a new course to @course' do
      get :new
      expect(assigns(:course)).to be_a_new(Course)
    end

    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested course' do
      delete :destroy, params: { id: course.id }

      expect(response).to redirect_to(courses_path)
      expect(flash[:notice]).to eq('Course was successfully destroyed.')

      expect { course.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
