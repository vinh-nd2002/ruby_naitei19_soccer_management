require "rails_helper"
include SessionsHelper

RSpec.describe User::FavoritePitchesController, type: :controller do
  let(:football_pitch) { create(:football_pitch) }
  let(:football_pitch_2) { create(:football_pitch) }
  let(:user) { create(:user) }

  before do
    log_in user
  end

  def create_favorite_pitch football_pitch_id
    post :create, params: { football_pitch_id: football_pitch_id }
  end

  describe "POST #create" do
    # Tất cả đều pass
    context "when valid conditions" do
      it "creates a favorite pitch" do
        expect {
          create_favorite_pitch football_pitch.id
        }.to change(user.favorite_pitches, :count).by(1)
      end

      it "displays flash success message when created successfully" do
        create_favorite_pitch football_pitch.id
        expect(flash[:success]).to eq(I18n.t("football_pitch.favorite.added"))
      end

      it "renders the root path when created successfully" do
        create_favorite_pitch football_pitch.id
        expect(response).to redirect_to(root_path)
      end
    end

    # Người dùng chưa login
    context "when user is not logged in" do
      before do
        session[:user_id] = nil
      end

      it "redirects to login page" do
        create_favorite_pitch football_pitch.id
        expect(response).to redirect_to(login_path)
      end
    end

    # Sân bóng không tồn tại
    context "when football pitch does not exist" do
      it "redirects to root path" do
        create_favorite_pitch 999
        expect(response).to redirect_to(root_path)
      end
    end

    # Sân bóng đã được yêu thích trước đó
    context "when football pitch already favorited by user" do
      before do
        user.favorite_pitches.create(football_pitch: football_pitch)
      end

      it "displays flash warning message" do
        create_favorite_pitch football_pitch.id
        expect(flash[:warning]).to eq(I18n.t("football_pitch.favorite.already_favorited"))
      end
    end
  end

  describe "DELETE #destroy" do
    before do
      @favorite_pitch = current_user.favorite_pitches.create(football_pitch: football_pitch)
    end

    context "when valid conditions" do
      it "deletes a favorite pitch" do
        expect {
          delete :destroy, params: { id: @favorite_pitch.id, football_pitch_id: football_pitch.id }
        }.to change(current_user.favorite_pitches, :count).by(-1)
      end

      it "displays flash success message when deleted successfully" do
        delete :destroy, params: { id: @favorite_pitch.id, football_pitch_id: football_pitch.id }
        expect(flash[:success]).to eq(I18n.t("football_pitch.favorite.removed"))
      end

      it "redirects to favorite_pitches_path when deleted successfully" do
        delete :destroy, params: { id: @favorite_pitch.id, football_pitch_id: football_pitch.id }
        expect(response).to redirect_to(favorite_pitches_path)
      end
    end

    context "when user is not logged in" do
      before do
        session[:user_id] = nil
      end

      it "redirects to login page" do
        delete :destroy, params: { id: @favorite_pitch.id, football_pitch_id: football_pitch.id }
        expect(response).to redirect_to(login_path)
      end
    end

    context "when football pitch does not exist" do
      it "redirects to root path" do
        delete :destroy, params: { id: @favorite_pitch.id, football_pitch_id: 999 }
        expect(response).to redirect_to(root_path)
      end
    end

    context "when football pitch is not favorited by user" do
      it "displays flash danger message" do
        delete :destroy, params: { id: @favorite_pitch.id, football_pitch_id: football_pitch_2.id }
        expect(flash[:danger]).to eq(I18n.t("football_pitch.favorite.remove_failed"))
      end
    end
  end
end
