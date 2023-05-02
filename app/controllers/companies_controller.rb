class CompaniesController < ApplicationController
  before_action :authenticate_user!, except: :show
  before_action :company_find, only: %i[show edit update]
  before_action :authorize_company

  def show; end

  def edit; end

  def update
    if @company.update(company_params)
      redirect_to @company
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def company_params
    params.require(:company).permit(:name, :address, :phone, :description)
  end

  def company_find
    @company = Company.find(params[:id])
  end

  def authorize_company
    authorize @company
  end
end
