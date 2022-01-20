# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :setup_session

  private

  def setup_session
    session[:session_id] ||= SecureRandom.hex
  end
end
