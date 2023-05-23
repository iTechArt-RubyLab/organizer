class StaticPagesController < ApplicationController
  before_action :set_company
  def home
  end

  def about
  end

  private

  def set_company
    @company = Company.find_by_name('Legenda')
  end
end
