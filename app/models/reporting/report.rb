class Report
  attr_accessor :date, :google, :brokers_web, :moss

  class BrokersWeb
    attr_accessor :engagements, :queries, :revenue

    def initialize(day)
      @queries = AdRequest.on_day(day).count
      @engagements = Revenue.on_day(day).where(source: 'VantageMedia').count
      @revenue = Money.new(Revenue.on_day(day).where(source: 'VantageMedia').sum(:amount)*100, 'USD')
      def cpe
        @engagements > 0 ? @revenue / @engagements : 0
      end
      def ctr
        @queries >0 ? @engagements / @queries.to_f : 0
      end
    end
  end

  class Moss
    attr_accessor :post, :sold

    def initialize(day)
      @post = Lead.on_day(day).count
      @sold = Revenue.on_day(day).where(source: 'Moss').count
    end
    def revenue
      Money.new(10*@sold*100, "USD")
    end
    def sold_rate
      @post >0 ? @sold / @post.to_f : 0
    end
  end

  def initialize(day)
    @date = day
    @google = CampaignReport.on_day(day)
    @moss = Moss.new(day)
    @brokers_web = BrokersWeb.new(day)
  end

  def clicks
    @google.clicks
  end

  def cost
    @google.cost
  end

  def revenue
    @moss.revenue + @brokers_web.revenue
  end

  def profit
    revenue - cost
  end

  def transactions
    @moss.sold + @brokers_web.engagements
  end

  def leads
    @moss.post
  end

  def lpc
    per_click(leads)
  end

  def tpc
    per_click(transactions)
  end

  def cpc
    per_click(cost)
  end

  def rpc
    per_click(revenue)
  end

  def epl
    per_lead(@brokers_web.engagements)
  end

  def rc_ratio
    per(cost, revenue)
  end

  def self.today
    Report.new(Time.zone.now.to_date)
  end

  def self.yesterday
    Report.new(Time.zone.now.to_date-1.day)
  end

  def per_click(value)
    per(clicks, value)
  end

  def per_transaction(value)
    per(transactions, value)
  end

  def per_lead(value)
    per(leads, value)
  end

  def per(divider, value)
    divider > 0 ? value / divider.to_f : 0
  end
end