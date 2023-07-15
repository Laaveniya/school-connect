# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EnrollmentsController, type: :controller do
  let(:user) { create(:admin_user) }
  let(:enrollment) { create(:enrollment) }

  describe 'GET #index' do
    it 'returns a successful response for school admin' do
      sign_in create(:user, role: :school_admin)
      get :index
      expect(response).to be_successful
    end

    it 'assigns enrollments for school admin' do
      sign_in create(:user, role: :school_admin)
      get :index
      expect(assigns(:enrollments)).to be_kind_of(ActiveRecord::Relation)
    end

    it 'renders the index template' do
      sign_in create(:user, role: :school_admin)
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    before do
      sign_in user
    end
    it 'returns a successful response' do
      get :show, params: { id: enrollment.id }
      expect(response).to be_successful
    end

    it 'assigns the requested enrollment to @enrollment' do
      get :show, params: { id: enrollment.id }
      expect(assigns(:enrollment)).to eq(enrollment)
    end

    it 'renders the show template' do
      get :show, params: { id: enrollment.id }
      expect(response).to render_template(:show)
    end
  end

  describe 'GET #new' do
    before do
      sign_in user
    end

    it 'returns a successful response for school admin' do
      sign_in create(:user, role: :school_admin)
      get :new
      expect(response).to be_successful
    end

    it 'returns a successful response for non-school admin' do
      sign_in create(:user, role: :student)
      get :new
      expect(response).to be_successful
    end

    it 'assigns a new enrollment to @enrollment' do
      sign_in create(:user, role: :school_admin)
      get :new
      expect(assigns(:enrollment)).to be_a_new(Enrollment)
    end

    it 'assigns schools for school admin' do
      user = create(:user, role: :school_admin)
      sign_in user
      get :new
      expect(assigns(:schools)).to eq(user.schools_administered)
    end

    it 'does not assign schools for non-school admin' do
      sign_in create(:user, role: :student)
      get :new
      expect(assigns(:schools)).to be_nil
    end

    it 'renders the new template' do
      sign_in create(:user, role: :school_admin)
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'DELETE #destroy' do
    before do
      sign_in user
    end
    it 'destroys the requested enrollment' do
      delete :destroy, params: { id: enrollment.id }

      expect(response).to redirect_to(enrollments_path)
      expect(flash[:notice]).to eq('Enrollment was successfully destroyed.')

      expect { enrollment.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end


