class PotagersController < ApplicationController
  skip_before_action :authenticate_user!

  def new
    @potager = Potager.new
  end

  def create
    @potager = Potager.new(params_for_potager)
    @potager.save
    if @potager.save
      redirect_to new_potager_choice_path(@potager)
    else
      p "error"
    end
    create_parcels
    create_vegetables_parcels
  end

  def show
    @potager = Potager.last
  end

  def update
    puts "Je suis dans update potager"
    @potager = Potager.find(params[:id])

    if @potager.update(params_for_potager)
      #on appelle les méthodes create_parcels et create_parcels_vegetables
      redirect_to potager_path(@potager)
    else
      render 'choices/new'
    end
  end

  private

  def params_for_potager
    params.require(:potager).permit(:length, :width, :freezing, :orientation, :start_month, choices_attributes: [:vegetable_id])
  end
end
