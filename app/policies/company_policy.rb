class CompanyPolicy < ApplicationPolicy
  def show?
    true
  end

  def edit?
    user.admin?
  end

  def update?
    user.admin?
  end
end
