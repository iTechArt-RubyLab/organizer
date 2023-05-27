require 'rails_helper'

RSpec.describe CompaniesController do
#   let(:user) { create(:user) }
#   let(:company) { create(:company) }
#
#   describe "#show" do
#     context "when user is authenticated" do
#       before { sign_in user }
#
#       it "renders the show template" do
#         get :show, params: { id: company.id }
#         expect(response).to render_template(:show)
#       end
#     end
#
#     context "when user is not authenticated" do
#       it "renders the show template" do
#         get :show, params: { id: company.id }
#         expect(response).to render_template(:show)
#       end
#     end
#   end
#
#   describe "#edit" do
#     context "when user is authenticated and authorized" do
#       before do
#         sign_in user
#         allow(controller).to receive(:authorize_company).and_return(true)
#       end
#
#       it "renders the edit template" do
#         get :edit, params: { id: company.id }
#         expect(response).to render_template(:edit)
#       end
#     end
#
#     context "when user is not authenticated" do
#       it "redirects to the sign in page" do
#         get :edit, params: { id: company.id }
#         expect(response).to redirect_to(new_user_session_path)
#       end
#     end
#
#     context "when user is authenticated but not authorized" do
#       before { sign_in user }
#
#       it "raises an error" do
#         expect { get :edit, params: { id: company.id } }.to raise_error(Pundit::NotAuthorizedError)
#       end
#     end
#   end
#
#   describe "#update" do
#     let(:valid_attributes) { attributes_for(:company) }
#     let(:invalid_attributes) { attributes_for(:company, name: "") }
#
#     context "when user is authenticated and authorized" do
#       before do
#         sign_in user
#         allow(controller).to receive(:authorize_company).and_return(true)
#       end
#
#       context "with valid attributes" do
#         it "updates the company and redirects to the show page" do
#           put :update, params: { id: company.id, company: valid_attributes }
#           expect(response).to redirect_to(company_path(company))
#         end
#       end
#
#       context "with invalid attributes" do
#         it "renders the edit template with a 422 status code" do
#           put :update, params: { id: company.id, company: invalid_attributes }
#           expect(response).to have_http_status(:unprocessable_entity)
#           expect(response).to render_template(:edit)
#         end
#       end
#     end
#
#     context "when user is not authenticated" do
#       it "redirects to the sign in page" do
#         put :update, params: { id: company.id, company: valid_attributes }
#         expect(response).to redirect_to(new_user_session_path)
#       end
#     end
#
#     context "when user is authenticated but not authorized" do
#       before { sign_in user }
#
#       it "raises an error" do
#         expect { put :update, params: { id: company.id, company: valid_attributes } }.to raise_error(Pundit::NotAuthorizedError)
#       end
#     end
#   end
end
