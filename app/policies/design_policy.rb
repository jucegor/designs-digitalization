class DesignPolicy < ApplicationPolicy
  # Every engineer will see only their active designs
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  # Every engineer can create a design
  def create?
    true
  end

  # Every engineer can see any design
  def show?
    true
  end

  # An engineer can destroy a design only if he created it
  def destroy?
    user_is_owner_or_admin
  end

  # An engineer can update a design only if he created it
  def update?
    # If the user is the owner of the design
    user_is_owner_or_admin || user.role == 'production_manager' || user.role == "engineer"
  end

  # An engineer can see all the designs created by him
  def all_designs?
    true
  end

  private

  def user_is_owner_or_admin
    user == record.user || user.admin
  end
end
