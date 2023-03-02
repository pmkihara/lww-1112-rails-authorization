class RestaurantPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      # Admin pode ver todos os restaurantes, os usuários só podem ver os que eles criaram
      if user.admin
        scope.all # a mesma coisa que Restaurant.all
      else
        Restaurant.where(user: user) # mesma coisa que Restaurant.where(user: current_user)
      end
    end
  end

  def show?
    # todos podem ver os detalhes de um restaurante
    true
  end

  def create?
    # todos podem criar um restaurante novo
    false
  end

  def update?
    # somente o usuário que criou pode editar
    owner?
  end

  def destroy?
    # somente o usuário que criou pode apagar
    owner?
  end

  private

  def owner?
    # record = restaurant
    # user = current_user
    record.user == user || user.admin # mesma coisa que @restaurant.user == current_user
  end
end
