require 'rails_helper'

RSpec.describe CompaniesController do
  let(:user) { create(:user) }
  let(:admin) { create(:user, role: 1) }
  let(:company) { create(:company) }

  describe '#show' do
    context 'when user is authenticated' do
      before { sign_in user }

      it 'has ok status' do
        get :show, params: { id: company.id }
        expect(response).to have_http_status(200)
      end
    end
  end

  describe '#edit' do
    context 'when user is authenticated and authorized' do
      before do
        sign_in admin
        allow(controller).to receive(:authorize_company).and_return(true)
      end

      it 'has ok status' do
        get :edit, params: { id: company.id }
        expect(response).to have_http_status(200)
      end
    end

    context 'when user is not authenticated' do
      it 'redirects to the sign in page' do
        get :edit, params: { id: company.id }
        expect(response).to redirect_to('/users/sign_in')
      end
    end
  end

  describe '#update' do
    let(:valid_attributes) { attributes_for(:company) }
    let(:invalid_attributes) { attributes_for(:company, name: '') }

    context 'when user is authenticated and authorized' do
      before do
        sign_in admin
        allow(controller).to receive(:authorize_company).and_return(true)
      end

      context 'with valid attributes' do
        it 'updates the company and redirects to the show page' do
          put :update, params: { id: company.id, company: valid_attributes }
          expect(response).to redirect_to(company_path(company))
        end
      end

      context ' "with invalid attributes"' do
        it 'renders the edit template with a 422 status code' do
          put :update, params: { id: company.id, company: invalid_attributes }
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end

    context 'when user is not authenticated' do
      it 'redirects to the sign in page' do
        put :update, params: { id: company.id, company: valid_attributes }
        expect(response).to redirect_to('/users/sign_in')
      end
    end
  end
end
