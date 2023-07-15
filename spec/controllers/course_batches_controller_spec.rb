# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CourseBatchesController, type: :controller do
  let(:user) { create(:admin_user) }
  let(:course_batch) { create(:course_batch) }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'assigns all course batches to @course_batches' do
      get :index
      expect(assigns(:course_batches)).to eq([course_batch])
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    it 'assigns the requested course batch to @course_batch' do
      get :show, params: { id: course_batch.id }
      expect(assigns(:course_batch)).to eq(course_batch)
    end

    it 'renders the show template' do
      get :show, params: { id: course_batch.id }
      expect(response).to render_template(:show)
    end
  end

  describe 'GET #new' do
    it 'assigns a new course batch to @course_batch' do
      get :new
      expect(assigns(:course_batch)).to be_a_new(CourseBatch)
    end

    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'DELETE #destroy' do
    it 'redirects to the course batches index' do
      delete :destroy, params: { id: course_batch.id }
      expect(response).to redirect_to(course_batches_url)
    end

    it 'sets a flash notice message' do
      delete :destroy, params: { id: course_batch.id }
      expect(flash[:notice]).to eq('Course batch was successfully destroyed.')
    end
  end
end
