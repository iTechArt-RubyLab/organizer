class BookingPolicy < ApplicationPolicy
  def index?
    user.admin? || user.user?
  end

  def show?
    user.admin? || user.user?
  end

  def new?
    user.admin? || user.user?
  end

  def create?
    user.admin? || user.user?
  end

  def edit?
    user.admin? || user.user?
  end

  def update?
    user.admin? || user.user?
  end

  def admin_export?
    user.admin?
  end

  def user_export?
    user.user? || user.admin?
  end
end
