require 'rails_helper'

RSpec.describe CompaniesController, type: :controller do
  let(:user) { create(:user) }
  let(:company) { create(:company) }

  # before do
  #   expect(controller).to receive(:authenticate_user!).and_return(true)
  # end

  describe "GET #new" do
    before do
      expect(controller).to receive(:authenticate_user!).and_return(true)
      get :new
    end

    it "is expected to assign person as new instance variable" do
      expect(assigns(:company)).to be_a_new(Company)
    end

    it "renders new template" do
      expect(assigns(:company)).to render_template(:new)
    end
  end

  describe "POST #create" do
    before do
      expect(controller).to receive(:authenticate_user!).and_return(true)
      expect(controller).to receive(:current_user).and_return(user)
    end

    context "when company is saved" do
      before do
        expect(company).to receive(:save).and_return(true)
      end

      it "redirects to companies path" do
        get :create

        expect(response).to redirect_to(company_path)
      end
    end

    context "when company is invalid" do
      before do
        expect(company).to receive(:valid?).and_return(false)
      end

      it "responds with unprocessable_entity" do
        get :create, params: param

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "GET #edit" do
    before do
      expect(controller).to receive(:current_user).and_return(user)
      expect(user).to receive(:companies).and_return(relation)
      expect(relation).to receive(:find).with(company.id.to_s).and_return(company)
    end

    it "renders edit" do
      get :edit, params: { id: company.id }

      expect(response).to have_http_status(:ok)
    end
  end

  describe "PUT #update" do
    before do
      expect(controller).to receive(:current_user).and_return(user)
      expect(user).to receive(:companies).and_return(relation)
      expect(relation).to receive(:find).with(company.id.to_s).and_return(company)
    end

    context "when company is updated" do
      before { expect(company).to receive(:update).and_return(true) }

      it "redirects to company path" do
        get :update, params: { id: company.id, company: param }

        expect(response).to redirect_to(companies_path)
      end
    end

    context "when company is not updated" do
      before { expect(company).to receive(:update).and_return(false) }

      it "responds with unprocessable_entity" do
        get :update, params: { id: company.id, company: param }

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE #destroy" do
    before do
      expect(controller).to receive(:current_user).and_return(user)
      expect(user).to receive(:companies).and_return(relation)
      expect(relation).to receive(:find).with(company.id.to_s).and_return(company)
      expect(company).to receive(:destroy).and_return(true)
    end

  end
end
