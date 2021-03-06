class ClientPolicy < ApplicationPolicy

  def index?
    true
  end

  def show?
    user.role == "admin" || user.role == "premium"
  end

  def create?
    user.role == "admin"
  end

  def update?
    user.role == "admin"
  end

  def destroy?
    user.role == "admin"
  end

  class Scope < Scope
    def resolve
      if user.role == 'admin'
        scope.all #.sort(:lloguer)
      else
        scope.where(lloguer: false)
      end
    end
  end
end
