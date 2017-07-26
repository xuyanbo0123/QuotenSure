require 'test_helper'

class IncidentsControllerTest < ActionController::TestCase
  setup do
    @incident = incidents(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:incidents)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create incident" do
    assert_difference('Incident.count') do
      post :create, incident: { accident_type_id: @incident.accident_type_id, at_fault: @incident.at_fault, claim_type_id: @incident.claim_type_id, damage_type_id: @incident.damage_type_id, driver_id: @incident.driver_id, incident_type_id: @incident.incident_type_id, month: @incident.month, paid_amount: @incident.paid_amount, rid: @incident.rid, state: @incident.state, ticket_type_id: @incident.ticket_type_id, year: @incident.year }
    end

    assert_redirected_to incident_path(assigns(:incident))
  end

  test "should show incident" do
    get :show, id: @incident
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @incident
    assert_response :success
  end

  test "should update incident" do
    patch :update, id: @incident, incident: { accident_type_id: @incident.accident_type_id, at_fault: @incident.at_fault, claim_type_id: @incident.claim_type_id, damage_type_id: @incident.damage_type_id, driver_id: @incident.driver_id, incident_type_id: @incident.incident_type_id, month: @incident.month, paid_amount: @incident.paid_amount, rid: @incident.rid, state: @incident.state, ticket_type_id: @incident.ticket_type_id, year: @incident.year }
    assert_redirected_to incident_path(assigns(:incident))
  end

  test "should destroy incident" do
    assert_difference('Incident.count', -1) do
      delete :destroy, id: @incident
    end

    assert_redirected_to incidents_path
  end
end
