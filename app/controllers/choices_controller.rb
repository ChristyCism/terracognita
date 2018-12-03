class ChoicesController < ApplicationController
  skip_before_action :authenticate_user!

  def new
    @potager = Potager.find(params[:potager_id])
    @vegetables = Vegetable.where("'Mai'=ANY(month_planted)")
  end

end
