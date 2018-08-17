class ClientPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end

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
  end
end
