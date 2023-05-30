require 'rails_helper'

RSpec.describe BookingsController do
  let(:user) { create(:user) }
  let(:company) { create(:company) }
  let(:service) { create(:service, company:) }
  let(:booking) { create(:booking, user:, service:) }
  let(:valid_attributes) { attributes_for(:booking) }
  let(:invalid_attributes) { attributes_for(:booking, start_at: DateTime.now - 1.hour) }

  describe 'GET /index' do
    context 'when user is authenticated' do
      before { sign_in user }
      it 'renders the show template' do
        get :index
        expect(response).to be_successful
      end
    end
  end

  describe 'GET /new' do
    before { sign_in user }
    it 'renders a successful response' do
      get :new, params: { id: booking.id }
      expect(response).to be_successful
    end
  end

  describe '#update' do
    context 'when user is authenticated and authorized' do
      before do
        sign_in user
        allow(controller).to receive(:authorize_booking).and_return(true)
      end

      context 'with valid attributes' do
        it 'updates the company and redirects to the show page' do
          put :update, params: { id: booking.id, booking: valid_attributes }
          expect(response).to redirect_to(bookings_path)
        end
      end

      context ' "with invalid attributes"' do
        it 'renders the edit template with a 422 status code' do
          put :update, params: { id: booking.id, booking: invalid_attributes }
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end

    context 'when user is not authenticated' do
      it 'redirects to the sign in page' do
        put :update, params: { id: booking.id, booking: valid_attributes }
        expect(response).to redirect_to('/users/sign_in')
      end
    end
  end
end
