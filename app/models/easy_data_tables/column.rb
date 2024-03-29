# frozen_string_literal: true

module EasyDataTables
  # Column class, we can access the formated data and the data of a particular cell
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
      @date_format = args[:date_format] || :default
      @values = construct_values
    end

    def formated_data_at(row)
      send(@type.downcase, row)
    end

    def data_at(row)
      @values[row]
    end

    protected

    def integer(row)
      helpers.number_with_delimiter(data_at(row))
    end

    def percentage(row)
      helpers.number_to_percentage(data_at(row), precision: 2)
    end

    def currency(row)
      helpers.number_to_currency(data_at(row))
    end

    def date(row)
      begin
        I18n.l(data_at(row), format: @date_format)
      rescue I18n::ArgumentError
        data_at(row)
      end
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
