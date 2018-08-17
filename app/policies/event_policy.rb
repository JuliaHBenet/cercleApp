class EventPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end

    def index?
      true
    end

    def show?
      true
    end

    def create?
      user.role == admin || user.role == premium
    end

    def update?
      user.role == admin || user.role == premium
    end

    def destroy?
      user.role == admin || user.role == premium
    end

  end
end
