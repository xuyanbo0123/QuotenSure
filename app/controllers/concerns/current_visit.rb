module CurrentVisit
  extend ActiveSupport::Concern

  private

  def set_visit
    @visit = Visit.current(session[:visit_id], session[:visit_uuid])
    if @visit.nil?
      @visit = Visit.new do |u|
        u.uuid = SecureRandom.uuid
        u.ip = request.remote_ip
        u.browser = request.user_agent
        u.device = request.env['mobvious.device_type']
        u.gclid = params[:gclid]
      end
    end
    @visit.geo_id ||= params[:lp]
    @visit.ad_group_gid ||= params[:ag]
    @visit.campaign_gid ||= params[:cp]
    @visit.feed_item_gid ||= params[:fi]
    @visit.target_gid ||= params[:t]
    @visit.keyword_gid ||= parse_keyword_gid(@visit.target_gid)
    @visit.save!
    session[:visit_id] = @visit.id
    session[:visit_uuid] = @visit.uuid
  end

  def set_meta
    page_keywords = 'cheap auto insurance, auto insurance quotes, free car insurance quotes'
    puts @visit.inspect
    if @visit.present?
      ad_group = AdGroup.find_by_gid(@visit.ad_group_gid)
      if ad_group.present?
        puts ad_group.inspect
        page_keywords = ad_group.ad_group_keywords.pluck(:keyword).join(', ')
      end
    end
    set_meta_tags :title => 'Free Auto Insurance Quotes',
                  :description => 'QuotenSure is a cost-free tool that makes searching for auto insurance a snap. No need to fill out forms on multiple sites. Step through our simple, fast, easy-to-understand questionnaire, compare quotes from different insurers and agents, and start saving on your car insurance in under 5 minutes.',
                  :keywords => page_keywords
  end

  def parse_keyword_gid(target_gid)
    if target_gid.present?
      target_gid.match(/kwd-([[:digit:]]+)/)[1]
    end
  end

  def get_visit
    @visit = Visit.current(session[:visit_id], session[:visit_uuid])
  end

end