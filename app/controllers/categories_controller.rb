class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_category, only: %i[show edit update]
  before_action :authorize_category

  def index
    @categories = Category.all
  end

  def show; end

  def new
    @category = Category.new
  end

  def edit; end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to category_url(@category)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @category.update(category_params)
      redirect_to category_url(@category)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name, :status)
  end

  def authorize_category
    authorize @category || Category
  end
end
