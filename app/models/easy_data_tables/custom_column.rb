# frozen_string_literal: true

module EasyDataTables
  # column where each value is a custom column
  class CustomColumn < Column
    def initialize(args = {})
      super(args)
      @values = args[:values]
      @partial = args[:partial] || ''
    end

    def formated_data_at(row)
      @values[row]
    end

    def data_at(_row)
      ''
    end

    private

    def construct_values; end

    def helpers
      ActionController::Base.helpers
    end
  end
end
