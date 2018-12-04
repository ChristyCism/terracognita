class PotagersController < ApplicationController
  skip_before_action :authenticate_user!

  before_action :set_potager, only: [:show, :update, :engine]

  def engine
  end

  def new
    @potager = Potager.create!(width: 3, length: 3, orientation: 'C')
    redirect_to potager_build_path(@potager, :def_intro)
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
  end

  def show
    @veg_parcels = VegetablesParcel.where(params[:potager_id])
  end

  def update
    @potager = Potager.find(params[:id])
    p params
    @potager.choices.destroy_all if params[:potager].key? :choices_attributes
    if @potager.update(params_for_potager)
      @potager.create_vegetables_parcels
      redirect_to engine_potager_path(@potager)
    else
      render 'choices/new'
    end
  end

  private

  def set_potager
    @potager = Potager.find(params[:id])
  end

  def params_for_potager
    params.require(:potager).permit(:length, :width, :freezing, :orientation, :start_month, choices_attributes: [:vegetable_id])
  end
end
