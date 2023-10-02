require 'rails_helper'
include SessionsHelper

RSpec.describe Admin::FootballPitchesController, type: :controller do
  let(:user) { create :user }
  before { log_in user }

  describe "GET #index" do
    it "assigns @football_pitches with the newest football pitches" do
      football_pitch1 = create :football_pitch, created_at: 1.day.ago
      football_pitch2 = create :football_pitch, created_at: 2.days.ago
      football_pitch3 = create :football_pitch, created_at: Time.now

      get :index
      expect(response).to be_successful
      expect(assigns(:football_pitches)).to eq([football_pitch3, football_pitch1, football_pitch2])
    end
  end

  describe "GET #show" do
    context "when @football_pitch is nil" do
      before { get :show, params: { id: 123 } }

      it "check status is unprocessable_entity" do
        expect(response).to have_http_status :unprocessable_entity
      end

      it "does not assign @football_pitch" do
        expect(assigns(:football_pitch)).to be_nil
      end
    end

    context "when @football_pitch is found" do
      let(:football_pitch) { create :football_pitch }

      before { get :show, params: { id: football_pitch.id } }

      it "renders the show template" do
        expect(response).to render_template :show
      end

      it "assigns @football_pitch" do
        expect(assigns(:football_pitch)).to eq football_pitch
      end
    end
  end

  describe "POST #create" do
    let(:valid_params) { attributes_for :football_pitch }
    let(:invalid_params) { attributes_for :football_pitch, name: nil }

    context "with valid parameters" do
      it "creates a new football pitch" do
        expect do
          post :create, params: { football_pitch: attributes_for(:football_pitch).merge(valid_params) }
        end.to change(FootballPitch, :count).by 1
      end

      it "sets a success flash message" do
        post :create, params: { football_pitch: attributes_for(:football_pitch).merge(valid_params) }
        expect(flash[:success]).to eq I18n.t("football_pitches.create.success")
      end

      it "redirects to admin_football_pitches_path" do
        post :create, params: { football_pitch: attributes_for(:football_pitch).merge(valid_params) }
        expect(response).to redirect_to admin_football_pitches_path
      end
    end

    context "with invalid parameters" do
      it "does not create a new football pitch" do
        expect do
          post :create, params: { football_pitch: attributes_for(:football_pitch).merge(invalid_params) }
        end.not_to change FootballPitch, :count
      end

      it "renders the new template with unprocessable_entity status" do
        post :create, params: { football_pitch: attributes_for(:football_pitch).merge(invalid_params) }
        expect(response).to render_template :new
        expect(response).to have_http_status :unprocessable_entity
      end
    end
  end

  describe "PATCH #update" do
    let(:football_pitch) { create :football_pitch }
    let(:valid_params) do
      {
        name: "Updated Name",
        location: "Updated Location",
        length: 12.5,
        width: 25.0,
      }
    end

    let(:invalid_params) do
      {
        name: nil,
        location: "Updated Location",
        length: 12.5,
        width: 25.0,
      }
    end

    context "with valid parameters" do
      it "updates the football pitch" do
        patch :update, params: { id: football_pitch.id, football_pitch: valid_params }
        football_pitch.reload
        expect(football_pitch.name).to eq "Updated Name"
        expect(football_pitch.location).to eq "Updated Location"
      end

      it "sets a success flash message" do
        patch :update, params: { id: football_pitch.id, football_pitch: valid_params }
        expect(flash[:success]).to eq I18n.t("football_pitches.update.success")
      end

      it "redirects to admin_football_pitch_path" do
        patch :update, params: { id: football_pitch.id, football_pitch: valid_params }
        expect(response).to redirect_to admin_football_pitch_path football_pitch
      end
    end

    context "with invalid parameters" do
      it "does not update the football pitch" do
        patch :update, params: { id: football_pitch.id, football_pitch: invalid_params }
        football_pitch.reload
        expect(football_pitch.name).not_to be_nil
      end

      it "renders the edit template with unprocessable_entity status" do
        patch :update, params: { id: football_pitch.id, football_pitch: invalid_params }
        expect(response).to render_template :edit
        expect(response).to have_http_status :unprocessable_entity
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:football_pitch) { FactoryBot.create :football_pitch }

    context "when the football pitch is successfully destroyed" do
      it "destroys the football pitch" do
        expect do
          delete :destroy, params: { id: football_pitch.id }
        end.to change(FootballPitch, :count).by -1
      end

      it "sets a success flash message" do
        delete :destroy, params: { id: football_pitch.id }
        expect(flash[:success]).to eq I18n.t("football_pitches.delete.success").capitalize
      end

      it "redirects to admin_football_pitches_path with status :see_other" do
        delete :destroy, params: { id: football_pitch.id }
        expect(response).to redirect_to admin_football_pitches_path
        expect(response).to have_http_status :see_other
      end
    end

    context "when the football pitch cannot be destroyed" do
      before { allow_any_instance_of(FootballPitch).to receive(:destroy).and_return false }

      it "does not destroy the football pitch" do
        expect do
          delete :destroy, params: { id: football_pitch.id }
        end.not_to change FootballPitch, :count
      end

      it "sets a danger flash message" do
        delete :destroy, params: { id: football_pitch.id }
        expect(flash[:danger]).to eq I18n.t("football_pitches.delete.failed").capitalize
      end

      it "redirects to admin_football_pitches_path with status :see_other" do
        delete :destroy, params: { id: football_pitch.id }
        expect(response).to redirect_to admin_football_pitches_path
        expect(response).to have_http_status :see_other
      end
    end
  end
end
