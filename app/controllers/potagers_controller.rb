class PotagersController < ApplicationController
  skip_before_action :authenticate_user!

  def new
    @potager = Potager.new
  end

  def create
    @new_potager = Potager.new(params_for_potager)
    @new_potager.save
    if @new_potager.save
      redirect_to new_potager_choice_path(@new_potager)
    else
      p "error"
    end
    create_parcel
    create_parcel_vegetables
  end

  private

  def params_for_potager
    params.require(:potager).permit(:length, :width, :freezing, :orientation, :start_month)
  end

  def create_parcel
    # Parcel.new
    # @potager.width
    # @potager.length
    # @potager

  end

  def create_parcel_vegetables
    # ParcelVegetable.new
    # @parcel
    # Vegatable.find

  end

end
