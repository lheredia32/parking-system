# frozen_string_literal: true

# ...
class SessionsController < ApplicationController
  allow_unauthenticated_access only: %i[new create]
  before_action :resume_session, only: %i[new]
  rate_limit to: 10, within: 3.minutes, only: :create, with: lambda {
    redirect_to new_session_url, alert: 'Intenta de nuevo más tarde.'
  }

  def new; end

  def create
    user = User.find_by(email_address: params[:email_address])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      Current.user = user
      start_new_session_for(user)
      redirect_to root_path, notice: 'Inicio de sesión exitoso.'
    else
      redirect_to new_session_path, alert: 'Correo electrónico o contraseña incorrectos.'
    end
  end

  def destroy
    session[:user_id] = nil
    Current.user = nil
    redirect_to new_session_path
  end
end
