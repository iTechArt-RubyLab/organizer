class ServicesController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :company_find
  before_action :service_find, only: %i[show edit update]
  before_action :authorize_service

  def index
    @pagy, @services = pagy(@company.services.active, items: 1)
  end

  def show; end

  def new
    @service = Service.new
  end

  def create
    @service = @company.services.new(service_params)
    if @service.save
      redirect_to company_services_path(@company)
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

  def search
    search_field = params[:search].present? ? params[:search] : '*'
    category_id = params[:category].present? ? params[:category].to_i : nil
    @services = if category_id
                  Service.search(search_field, where: {category_id: })
                else
                  Service.search(search_field)
                end
  end

  private

  def service_params
    params.require(:service).permit(:name, :description, :duration, :price, :company_id, :image, :category_id)
  end

  def company_find
    @company = Company.find(params[:company_id])
  end

  def service_find
    @service = @company.services.find(params[:id])
  end

  def authorize_service
    authorize @service || Service
  end
end
