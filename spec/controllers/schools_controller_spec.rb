# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SchoolsController, type: :controller do
  let!(:school) { create(:school) }
  let(:school_params) { { name: 'School 1', address: 'Bangalore' } }
  before do
    user = create(:admin_user)
    sign_in user
  end
  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new school" do
        expect {
          post :create, params: { school: school_params }
        }.to change(School, :count).by(1)
      end

      it "redirects to the created school" do
        post :create, params: { school: school_params }
        expect(response).to redirect_to(School.last)
      end
    end

    context "with invalid parameters" do
      it "does not create a new school" do
        expect {
          post :create, params: { school: { name: nil } }
        }.to_not change(School, :count)
      end

      it "renders the :new template" do
        post :create, params: { school: { name: nil } }
        expect(response.code).to eq('422')
      end
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      get :show, params: { id: school.id }
      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      get :edit, params: { id: school.id }
      expect(response).to be_successful
    end
  end

  describe "PATCH #update" do
    context "with valid parameters" do
      it "updates the requested school" do
        patch :update, params: { id: school.id, school: { name: "New Name" } }
        school.reload
        expect(school.name).to eq("New Name")
      end

      it "redirects to the school" do
        patch :update, params: { id: school.id, school: { name: "New Name" } }
        expect(response).to redirect_to(school)
      end
    end

    context "with invalid parameters" do
      it "does not update the school" do
        original_name = school.name
        patch :update, params: { id: school.id, school: { name: nil } }
        school.reload
        expect(school.name).to eq(original_name)
      end

      it "renders the :edit template" do
        patch :update, params: { id: school.id, school: { name: nil } }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested school" do
      expect {
        delete :destroy, params: { id: school.id }
      }.to change(School, :count).by(-1)
    end

    it "redirects to the schools list" do
      delete :destroy, params: { id: school.id }
      expect(response).to redirect_to(schools_url)
    end
  end
end
