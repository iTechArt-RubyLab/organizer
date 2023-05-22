class SearchController < ApplicationController
  def search
    @company = Company.find_by(name: 'Legenda')
    @services = if params[:term].nil?
                  [] 
                else
                  @company.services.search params[:term] 
                end
  end
end
