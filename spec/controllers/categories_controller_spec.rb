require 'rails_helper'

RSpec.describe CategoriesController do
  let(:admin) { create(:user, role: 1) }
  let(:category) { create(:category) }
  let(:valid_attributes) { attributes_for(:category) }
  let(:invalid_attributes) { attributes_for(:category, name: '') }

  describe 'GET /index' do
    context 'when user is authenticated' do
      before { sign_in admin }
      it 'renders the show template' do
        get :index
        expect(response).to be_successful
      end
    end
  end

  describe 'GET /show' do
    before { sign_in admin }
    it 'renders a successful response' do
      get :show, params: { id: category.id, company: valid_attributes }
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    before { sign_in admin }
    it 'renders a successful response' do
      get :new, params: { id: category.id }
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    before { sign_in admin }
    it 'renders a successful response' do
      get :edit, params: { id: category.id }
      expect(response).to be_successful
    end
  end

  describe '#update' do
    context 'when user is authenticated and authorized' do
      before do
        sign_in admin
        allow(controller).to receive(:authorize_category).and_return(true)
      end

      context 'with valid attributes' do
        it 'updates the company and redirects to the show page' do
          put :update, params: { id: category.id, category: valid_attributes }
          expect(response).to redirect_to(category_path(category))
        end
      end

      context ' "with invalid attributes"' do
        it 'renders the edit template with a 422 status code' do
          put :update, params: { id: category.id, category: invalid_attributes }
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end

    context 'when user is not authenticated' do
      it 'redirects to the sign in page' do
        put :update, params: { id: category.id, category: valid_attributes }
        expect(response).to redirect_to('/users/sign_in')
      end
    end
  end

  describe 'POST /create' do
    before do
      sign_in admin
      allow(controller).to receive(:authorize_category).and_return(true)
    end
    context 'with valid parameters' do
      it 'creates a new Category' do
        expect do
          post :create, params: { category: valid_attributes }
        end.to change(Category, :count).by(1)
      end

      it 'redirects to the created category' do
        post :create, params: { category: valid_attributes }
        expect(response).to redirect_to(category_url(Category.last))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Category' do
        expect do
          post :create, params: { category: invalid_attributes }
        end.to change(Category, :count).by(0)
      end

      it 'renders a response with 422 status' do
        post :create, params: { category: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
