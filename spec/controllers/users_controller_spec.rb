# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create(:admin_user) }
  before do
    sign_in user
  end
  describe "GET #index" do
    before(:each) do
      User.reindex
    end
    it "assigns all users to @users" do
      user1 = create(:user)
      user2 = create(:user)
      get :index

      expect(assigns(:users)).to match_array([user, user1, user2])
    end

    it "searches for users when 'q' parameter is present" do
      user1 = create(:user, name: "John Doe")
      user2 = create(:user, name: "Jane Smith")
      User.search_index.refresh

      get :index, params: { q: "Doe" }

      expect(assigns(:users).results).to include(user1)
      expect(assigns(:users).results).not_to include(user2)
    end
  end

  describe "GET #show" do
    it "assigns the requested user to @user" do
      user = create(:user)

      get :show, params: { id: user.id }

      expect(assigns(:user)).to eq(user)
    end
  end

  describe "GET #edit" do
    it "assigns the requested user to @user" do
      user = create(:user)

      get :edit, params: { id: user.id }

      expect(assigns(:user)).to eq(user)
    end
  end

  describe "PATCH #update" do
    let(:user_1) { create(:user) }

    context "with valid parameters" do
      it "updates the user" do
        new_name = "Updated Name"

        patch :update, params: { id: user_1.id, user: { name: new_name, password: user_1.password } }
        user_1.reload

        expect(user_1.name).to eq(new_name)
      end

      it "redirects to the updated user" do
        patch :update, params: { id: user_1.id, user: { name: "Updated Name", password: user_1.password } }

        expect(response).to redirect_to(user_url(user_1))
      end
    end

    context "with invalid parameters" do
      it "does not update the user" do
        old_name = user.name

        patch :update, params: { id: user.id, user: { name: "" } }
        user.reload

        expect(user.name).to eq(old_name)
      end

      it "renders the 'edit' template" do
        patch :update, params: { id: user.id, user: { name: "" } }

        expect(response).to render_template(:edit)
      end
    end
  end

  describe "DELETE #destroy" do
    let(:user) { create(:user) }

    it "destroys the user" do
      expect {
        delete :destroy, params: { id: user.id }
      }.to change(User, :count).by(-1)
    end

    it "redirects to the users index" do
      delete :destroy, params: { id: user.id }

      expect(response).to redirect_to(users_url)
    end
  end
end
