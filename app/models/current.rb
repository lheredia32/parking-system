# frozen_string_literal: true

# ...
class Current < ActiveSupport::CurrentAttributes
  attribute :user, :session

  # def session
  #   @session ||= Session.new
  # end

  # delegate :user, to: :session, allow_nil: true
end
