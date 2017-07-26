class IpToLocationsController < ApplicationController

  # GET zip_codes/:zip_code.json
  def get_state
    @ip_to_location = IpToLocation.find_by_zip_code(params[:zip_code])
    respond_to do |format|
      format.json { render json: @ip_to_location }
    end
  end

  # GET validate_zip/:zip_code.json
  def validate_zip
    ip_to_location = IpToLocation.find_by_zip_code(params[:zip_code])
    response = true
    if ip_to_location.nil?
      response = false;
    end
    respond_to do |format|
      format.json { render json: response }
    end
  end
end
