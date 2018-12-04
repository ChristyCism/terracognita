class ChoicesController < ApplicationController
  skip_before_action :authenticate_user!

  def new
    @potager = Potager.find(params[:potager_id])
    @month = @potager.start_month
    @vegetables = Vegetable.where("?=ANY(month_planted)", @month)
  end
end
