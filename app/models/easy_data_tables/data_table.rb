# frozen_string_literal: true

module EasyDataTables
  # creates the datatable and it's columns
  class DataTable
    attr_reader :columns, :rows, :labels

    def initialize(columns, rows, grouping)
      @grouping = grouping
      @rows = rows + ['TOTAL']
      @columns = treat_columns(columns)
      @labels = @columns.map(&:label)
    end

    private

    def treat_columns(columns)
      convert_columns(columns)
      columns.map! do |col|
        if col.is_a?(CombinedColumn)
          col.columns = columns.find_all { |col2| col.columns.include?(col2.label) }.sort do |column|
            col.columns.index(column.label)
          end 
        end
        col
      end
    end

    def convert_columns(columns)
      columns.map! do |col|
        case col[:column_type]
        when 'combined'
          CombinedColumn.new(col)
        when 'custom'
          CustomColumn.new(col)
        else
          Column.new(col.merge(grouping: @grouping))
        end
      end
    end
  end
end
