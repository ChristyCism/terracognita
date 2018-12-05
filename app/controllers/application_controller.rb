class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!

  def default_url_options
    { host: ENV["HOST"] || "localhost:3000" }
  end

  def after_sign_in_path_for(resource)
    @potager = Potager.last
    potager_path(@potager)
  end

  # def after_sign_in_path_for(resource)
  #   current_user_path
  # end
end
