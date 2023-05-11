class StaticPagesController < ApplicationController
  def home
    @company = Company.find_by(name: "Legenda")
  end
end
