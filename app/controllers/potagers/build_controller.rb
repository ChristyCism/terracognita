class Potagers::BuildController < ApplicationController
skip_before_action :authenticate_user!
include Wicked::Wizard

steps :def_intro, :def_dimension, :def_orientation, :def_soil, :def_freezing, :def_start_month

def show
  @potager = Potager.find(params[:potager_id])

  render_wizard
end


def update
  @potager = Potager.find(params[:potager_id])
  params[:potager][:status] = 'active' if step == steps.last
  @potager.update_attributes!(params_set) if params.key? :potager
  @potager.create_parcels if step == steps.last
  render_wizard @potager
end


def create
  @potager = Potager.create
  redirect_to wizard_path(steps.first, :potager_id => @potager.id)
end

private

def params_set
  params.require(:potager).permit(:length, :width, :orientation, :freezing, :start_month)
end

def finish_wizard_path
  new_potager_choice_path
end

end
