# app/controllers/application_controller.rb
class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
  
    protected
  
    # Redireccionar después de iniciar sesión
    def after_sign_in_path_for(resource)
      galleries_path
    end
  
    # Redireccionar después de cerrar sesión
    def after_sign_out_path_for(resource_or_scope)
      root_path
    end


    def configure_permitted_parameters
      # Permitir parámetros para registrarse
      devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation])
  
      # Permitir parámetros para actualizar la cuenta
      devise_parameter_sanitizer.permit(:account_update, keys: [:email, :password, :password_confirmation, :current_password])
    end
  
    # Redireccionar después del registro
    def after_sign_up_path_for(resource)
      new_user_session_path
    end
  end
  