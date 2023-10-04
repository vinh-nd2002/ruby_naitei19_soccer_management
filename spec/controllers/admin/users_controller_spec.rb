require "rails_helper"
include SessionsHelper

RSpec.describe Admin::UsersController, type: :controller do
  let(:admin_user) { create(:user, is_admin: true) }

  before do
    log_in admin_user
  end

  describe "GET #index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "GET #show" do
    let(:user) { create(:user) }

    context "when user exists" do
      it "renders the show template" do
        get :show, params: { id: user.id }
        expect(response).to render_template(:show)
      end
    end

    context "when user does not exist" do
      it "redirects to the root path" do
        get :show, params: { id: 999 }
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "DELETE #destroy" do
    let(:user_to_delete) { create(:user) }
    let(:non_existent_user_id) { 9999 }
    context "when the user does not exist" do
      it "redirects to the root path" do
        delete :destroy, params: { id: non_existent_user_id }
        expect(response).to redirect_to(admin_users_path)
      end
    end

    context "when valid condition" do
      it "deletes the user" do
        expect {
          delete :destroy, params: { id: user_to_delete.id }
        }
      end

      it "displays a flash message if successful" do
        delete :destroy, params: { id: user_to_delete.id }
        expect(flash[:success]).to eq(I18n.t("users.delete.success"))
      end

      it "redirects to admin_users_path if delete is successful" do
        delete :destroy, params: { id: user_to_delete.id }
        expect(response).to redirect_to(admin_users_path)
      end
    end
  end
end
