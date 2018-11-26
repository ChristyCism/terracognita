class PotagerController < ApplicationController
    skip_before_action :authenticate_user!

    def new
      @potager = Potager.new
    end

    def create
      @new_potager = Potager.new(params_for_potager)
      if
    end

private

  def params_for_potager

    params.require(:potager).permit(:length, :width, :freeze, :orientation, :start_month)

end
