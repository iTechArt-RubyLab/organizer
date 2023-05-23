class ServicePolicy < ApplicationPolicy

  def index?
    true
  end

  def show?
    true
  end

  def new?
    user.admin?
  end

  def create?
    user.admin?
  end

  def edit?
    user.admin?
  end

  def update?
    user.admin?
  end

  def search?
    true
  end
end