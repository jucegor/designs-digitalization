class AnswerPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end
  def create?
    true
  end
  def edit?
    user_is_owner_or_admin
  end
  def update?
    true
  end
  def destroy?
    user_is_owner_or_admin
  end



  private

  def user_is_owner_or_admin
    user.responsible == record.user || user.admin
  end
end
