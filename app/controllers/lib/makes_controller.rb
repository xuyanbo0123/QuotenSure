class MakesController < ApplicationController

  # GET years/:year/makes.json
  def unique_makes
    make_ids = Car.unique_make_ids(params[:year])
    makes = Make.order(:name).find(make_ids)
    respond_to do |format|
      format.json { render json: makes }
    end
  end

end
