class ServicesController < ApplicationController
  before_action :company_find
  before_action :service_find, only: %i[show edit update destroy]

  def index
    @services = @company.services.all
  end

  def show; end

  def new
    @service = Service.new
  end

  def create
    @service = @company.services.new(service_params)
    if @service.save
      redirect_to company_services_url
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @service.update(service_params)
      redirect_to company_services_path(@company)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @service.destroy
    redirect_to company_services_path(@company)
  end

  private

  def service_params
    params.require(:service).permit(:name, :description, :duration, :price, :company_id)
  end

  def company_find
    @company = Company.find(params[:company_id])
  end

  def service_find
    @service = @company.services.find(params[:id])
  end

end
