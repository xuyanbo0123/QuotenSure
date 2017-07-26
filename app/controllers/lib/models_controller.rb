class ModelsController < ApplicationController

  # GET years/:year/makes/:make/models.json
  def unique_models
    model_ids = Car.unique_model_ids(params[:year], params[:make])
    models = Model.order(:name).find(model_ids)
    respond_to do |format|
      format.json { render json: models }
    end
  end

end