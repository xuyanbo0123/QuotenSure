module ManagementConsoleHelper
  def to_dollar(micro)
    if micro.present?
      micro / 1000000.0
    end
  end
end
