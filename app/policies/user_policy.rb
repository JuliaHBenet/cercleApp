class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
    def index?
      user.role == admin
    end

    def show?
      user.role == admin
    end

    def create?
      user.role == admin
    end

    def update?
      user.role == admin
    end

    def destroy?
      user.role == admin
    end
  end
end
