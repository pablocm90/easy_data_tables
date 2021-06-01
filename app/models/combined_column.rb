# frozen_string_literal: true


class CombinedColumn < Column
  attr_accessor :columns

  def initialize(args = {})
    super(args)
    @columns = args[:columns]
    @method = args[:method]
    @type = args[:type]
    @label = args[:label]
  end

  def data_at(row)
    combine(row)
  end

  private

  def combine(row)
    case @method
    when 'rate'
      columns[0].data_at(row).fdiv(columns[1].data_at(row)) * 100
    when 'substract'
      columns[0].data_at(row) - columns[1].data_at(row)
    end
  end

  def construct_values; end

  def helpers
    ActionController::Base.helpers
  end
end
