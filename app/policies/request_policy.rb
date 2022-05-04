class RequestPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  # Everyone can see all the requests table
  def all_requests?
    user_is_admin || user.role == 'production_manager'
  end

  # Only the production manager creates the request for a design
  def create?
    true
  end

  def show?
    true
  end

  # The production manager can delete it's requested designs
  def destroy?
    user_is_admin || user.role == 'production_manager'
  end

  # An engineer can update a design only if he created it
  def update?
    # If the user is the owner of the design
    user_is_admin || user.role == 'production_manager' || user.role == "engineer"
  end

  private

  def user_is_admin
    user == user.admin
  end
end
