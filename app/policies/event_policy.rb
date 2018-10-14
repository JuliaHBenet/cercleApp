class EventPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    (user.role == "admin") || record.lloguer == false
  end

  def create?
    user.role == "admin" || user.role == "premium"
  end

  def update?
    user.role == "admin" || user.role == "premium"
  end

  def destroy?
    user.role == "admin" || user.role == "premium"
  end

  def accept_or_decline?
    user.role == "admin"
  end

  def obert_o_tancat?
    user.role == "admin"
  end

  class Scope < Scope
    def resolve
      if (user.role == "admin")
        scope.all
      else
        scope.where(lloguer: false)
      end
    end
  end
end
