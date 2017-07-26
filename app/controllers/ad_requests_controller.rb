class AdRequestsController < ApplicationController
  include CurrentVisit
  before_action :set_visit, :set_brand, only: [:new]
  before_action :get_visit, only: [:show, :create]
  before_action :set_ad_request, only: [:show, :edit, :update, :destroy]
  before_action :set_meta
  # GET /ad_requests
  # GET /ad_requests.json
  def index
    @ad_requests = AdRequest.all
  end

  # GET /ad_requests/1
  # GET /ad_requests/1.json
  def show
  end

  # GET /ad_requests/new
  def new
    @ad_request = @visit.ad_requests.build
    @ad_request.set_city_state(params)
  end

  # GET /ad_requests/1/edit
  def edit
  end

  # POST /ad_requests
  # POST /ad_requests.json
  def create
    @ad_request = @visit.ad_requests.build(ad_request_params)
    @ad_request.sender = :_pop_under
    @ad_request.fetch_ads

    respond_to do |format|
      if @ad_request.save
        format.html { redirect_to @ad_request, notice: 'Ad request was successfully created.' }
      else
        @ad_request.send_error_notification
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /ad_requests/1
  # PATCH/PUT /ad_requests/1.json
  def update
    respond_to do |format|
      if @ad_request.update(ad_request_params)
        format.html { redirect_to @ad_request, notice: 'Ad request was successfully updated.' }
        format.json { render :show, status: :ok, location: @ad_request }
      else
        format.html { render :edit }
        format.json { render json: @ad_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ad_requests/1
  # DELETE /ad_requests/1.json
  def destroy
    @ad_request.destroy
    respond_to do |format|
      format.html { redirect_to ad_requests_url, notice: 'Ad request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_ad_request
    # @ad_request = AdRequest.find(params[:id])
    @ad_request = AdRequest.friendly.find(params[:id])
  end

  def set_brand
    ad_group_gid = params[:ag]
    if ad_group_gid.present?
      @brand = Brand.find_by(ad_group_gid: ad_group_gid)
    end

    bid = params[:b]
    if bid.present?
      @brand = Brand.friendly.find(bid)
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def ad_request_params
    params.require(:ad_request).permit(:zip, :sender)
  end
end
