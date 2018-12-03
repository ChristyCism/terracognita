class PotagersController < ApplicationController
  skip_before_action :authenticate_user!


    def new
    @potager = Potager.create!(width: 3, length: 3, orientation: 'C')
    redirect_to potager_build_path(@potager, :def_intro)
    end


    def create
    @new_potager = Potager.new(params_for_potager)
    @new_potager.save
    raise
    if @new_potager.save
      redirect_to new_potager_choice_path(@new_potager)
    else
      p "error"
    end
    # create_parcel
    # create_parcel_vegetables
  end

  def show
    @potager = Potager.last
  end

  def update
    @potager = Potager.find(params[:id])
    @vegetables = Vegetable.where("'Mai'=ANY(month_planted)")

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

  # def create_parcel
  #   @parcel = Parcel.new
  #   @parcel_width_side = ["a", "c"]
  #   @parcel_length_side = ["b", "d"]
  #   if @parcel_width_side.include?(params[:potager][:orientation])
  #     @parcel.length = 1
  #     @parcel.width = @new_potager.width
  #     @number_of_parcels = @new_potager.length
  #   else
  #     @parcel.length = @new_potager.length
  #     @parcel.width = 1
  #     @number_of_parcels = @new_potager.width
  #   end
  # end

  # def create_parcel_vegetables
    # ParcelVegetable.new
    # @parcel
    # Vegatable.find
  # end

end
