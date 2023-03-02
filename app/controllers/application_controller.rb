class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  include Pundit::Authorization

  # Pundit: allow-list approach
  # Procura a palavra authorize em todas as ações menos o index
  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  # Procura a palavra verify_scope apenas no index
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  # Uncomment when you *really understand* Pundit!
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(root_path)
  end

  private

  def skip_pundit?
    # Não utilizar o Pundit para os controllers do devise, admin e pages (páginas públicas)
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end
end
