class ZipCodesController < ApplicationController
  # GET zip_codes/:zip.json
  def get_city_state
    @zip_code = ZipCode.find_by_zip(params[:zip])
    respond_to do |format|
      format.json { render json: @zip_code }
    end
  end

  # GET validate_zip/:zip.json
  def validate_zip
    @zip_code = ZipCode.find_by_zip(params[:zip])
    response = true
    if @zip_code.nil?
      response = false
    end
    respond_to do |format|
      format.json { render json: response }
    end
  end
end
