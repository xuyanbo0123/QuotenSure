class LeadsController < ApplicationController
  layout "lead_wizard"
  include CurrentVisit
  before_action :set_visit, only: [:new]
  before_action :get_visit, only: [:create]
  before_action :set_lead, only: [:show, :edit, :update, :destroy]
  before_action :set_meta, only: [:new]

  # GET /leads
  # GET /leads.json
  def index
    redirect_to root_url
  end

  # GET /leads/1
  # GET /leads/1.json
  def show
  end

  # GET /leads/new
  def new
    @lead = Lead.new
    @lead.init_components
    @lead.contact.zip = params[:zip]
    @lead.contact.set_city_state
  end

  # GET /leads/1/edit
  def edit
  end

  # POST /leads
  # POST /leads.json
  def create
    @visit.conversion += 1
    @visit.save

    @lead = @visit.leads.build(lead_params)
    if @lead.save
      @lead.sell
      # @lead.delay.sell
    else
      @lead.send_error_notification(lead_params.to_s)
    end

    ad_request = @visit.ad_requests.build(:zip => @lead.contact.zip, :sender => :_after_form)
    ad_request.fetch_ads

    respond_to do |format|
      if ad_request.save
        format.html { redirect_to ad_request, notice: 'Lead was successfully created.' }
      else
        ad_request.send_error_notification
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /leads/1
  # PATCH/PUT /leads/1.json
  def update
    respond_to do |format|
      if @lead.update(lead_params)
        format.html { redirect_to @lead, notice: 'Lead was successfully updated.' }
        format.json { render :show, status: :ok, location: @lead }
      else
        format.html { render :edit }
        format.json { render json: @lead.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /leads/1
  # DELETE /leads/1.json
  def destroy
    @lead.destroy
    respond_to do |format|
      format.html { redirect_to leads_url, notice: 'Lead was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_lead
    @lead = Lead.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def lead_params
    params.require(:lead).permit(:token, :leadid_token, :status, :has_incident,
                                 vehicles_attributes: [:year_id, :make_id, :model_id, :owner_type_id, :vehicle_use_id, :annual_mileage_id, :commute_day_id, :garage_type_id, :coll_deduct_id, :comp_deduct_id, :rid],
                                 drivers_attributes: [:first_name, :last_name, :birthday, :gender_id, :marital_status_id, :relationship_id, :occupation_id, :education_id, :credit_id, :age_lic_id, :lic_status_id, :is_sr22_id, :rid],
                                 policy_attributes: [:request_coverage_id, :is_insured_id, :company_id, :expiration_date, :continuous_year_id],
                                 contact_attributes: [:address1, :address2, :zip, :city, :state, :email, :phone, :residence_status_id, :residence_year_id],
                                 incidents_attributes: [:driver_rid, :incident_type_id, :ticket_type_id, :claim_type_id, :accident_type_id, :year, :month, :at_fault, :damage_type_id, :paid_amount, :state])
  end
end
