# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user # current_user
    @record = record # instância a ser autorizada
  end

  # Por default, ninguém pode fazer nada
  def index?
    false
  end

  def show?
    false
  end

  def create?
    false
  end

  def new?
    create? # segue o mesmo comportamento do create? para não mostrar o form se não puder criar
  end

  def update?
    true
  end

  def edit?
    update? # segue o mesmo comportamento do update? para não mostrar o form se não puder editar
  end

  def destroy?
    false
  end

  class Scope
    def initialize(user, scope)
      @user = user # current_user
      @scope = scope # classe das instâncias ou uma coleção de instâncias
    end

    def resolve
      raise NotImplementedError, "You must define #resolve in #{self.class}"
    end

    private

    attr_reader :user, :scope
  end
end
