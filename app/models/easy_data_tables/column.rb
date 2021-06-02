# frozen_string_literal: true

# Column class, we can access the formated data and the data of a particular cell
module EasyDataTables
  class Column
    attr_reader :label

    # values = {}, label = '', type = 'Integer')
    def initialize(args = {})
      @label = args[:label] || ''
      @type = args[:type] || 'Integer'
      @default = args[:default] || 0
      @collection = args[:collection]
      @grouping = args[:grouping]
      @agregate_function = args[:agregate_function]
      @values = construct_values
    end

    def formated_data_at(row)
      case @type
      when 'Integer'
        helpers.number_with_delimiter(data_at(row))
      when 'Percentage'
        helpers.number_to_percentage(data_at(row), precision: 2)
      when 'Currency'
        helpers.number_to_currency(data_at(row))
      else
        data_at(row)
      end
    end

    def data_at(row)
      @values[row]
    end

    private

    def construct_values
      Hash.new(@default)
          .merge(@collection.send(*@grouping).send(*@agregate_function))
          .merge({ 'TOTAL' => @collection.send(*@agregate_function) })
    end

    def helpers
      ActionController::Base.helpers
    end
  end
end
