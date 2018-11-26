class ChoicesController < ApplicationController
  skip_before_action :authenticate_user!

  def new
    @choice = Choice.new
  end

  def create
    @new_choice = Choice.new(params_of_choice)
    @new_choice.save
    if @new_choice.save
      redirect_to potager_path(:potager_id)
    else
      p "error"
    end
  end

  private

  def params_of_choice
    params.require(:choice).permited(:vegetable_id, :potager_id)
  end
end
