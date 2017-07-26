class StaticPagesController < ApplicationController
  include CurrentVisit
  before_action :get_visit
  before_action :set_meta

  def about
  end

  def privacy_policy
  end

  def terms_of_use
  end
end
