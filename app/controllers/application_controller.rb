# frozen_string_literal: true

# ...
class ApplicationController < ActionController::Base
  include Authentication
  before_action :set_current_user

  private

  def set_current_user
    return unless session[:user_id]

    Current.user = User.find_by(id: session[:user_id])
  end

  def start_new_session_for(user)
    Current.user = user
    user.sessions.create!(user_agent: request.user_agent, ip_address: request.remote_ip).tap do |session|
      Current.session = session
      cookies.signed.permanent[:session_id] = { value: session.id, httponly: true, same_site: :lax }
    end
  end
end
