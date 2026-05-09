# frozen_string_literal: true

class Admin::UsersController < ApplicationController
  before_action :require_admin
  before_action :set_user, only: %i[edit update destroy]

  def index
    @users = User.all.order(created_at: :desc)
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "Usuario actualizado correctamente."
    else
      render :edit, alert: "Error al actualizar usuario."
    end
  end

  def destroy
    if @user == Current.user
      redirect_to admin_users_path, alert: "No puedes eliminar tu propio usuario."
    elsif @user.destroy
      redirect_to admin_users_path, notice: "Usuario eliminado correctamente."
    else
      redirect_to admin_users_path, alert: "Error al eliminar usuario."
    end
  end

  private

  def require_admin
    redirect_to root_path, alert: "Acceso denegado." unless Current.user.admin?
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:role, profile_attributes: [:name, :last_name, :phone_number])
  end
end