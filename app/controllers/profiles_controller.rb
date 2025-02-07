# frozen_string_literal: true

# ...
class ProfilesController < ApplicationController
  before_action :set_profile, only: %i[show edit update]

  def show; end

  def edit; end

  def update
    if @profile.update(profile_params)
      redirect_to profile_path(@profile), notice: 'Perfil actualizado con éxito.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_profile
    @profile = Current.user.profile
  end

  def profile_params
    params.require(:profile).permit(:name, :last_name, :phone_number)
  end
end
