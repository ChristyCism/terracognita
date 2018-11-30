class ChoicesController < ApplicationController
  skip_before_action :authenticate_user!

  def new
    @potager = Potager.find(params[:potager_id])
    @vegetables = Vegetable.where("'Mai'=ANY(month_planted)")
  end

  def create
    @new_choice = Choice.new(params_of_choice)
    p @new_choice


    if @new_choice.save
      redirect_to potager_path(:potager_id)
    else
      render_errors
    end
  end


  private

  def params_of_choice
    params.require(:choice).permit(:vegetable_id, :potager_id)
  end
end
