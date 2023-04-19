class EventPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all
    end
  end

  def create?
    user
  end

  def show?
    true
  end

  def update?
    true
  end

  def destroy?
    user
  end
end
