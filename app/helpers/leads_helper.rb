module LeadsHelper
  def pairs_with_prompt(value_type)
    add_prompt(value_type.pairs(:display))
  end

  def pairs(value_type)
    if value_type.selected_id.nil?
      add_prompt(value_type.pairs(:display))
    else
      value_type.pairs(:display)
    end
  end

  def pairs_no_param(value_type)
    if value_type.selected_id.nil?
      add_prompt(value_type.pairs)
    else
      value_type.pairs
    end
  end

  def add_prompt(arr)
    arr.unshift(['--', ''])
  end
end