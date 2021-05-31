module EasyDataTables
  class DataTable
    attr_reader :columns, :rows, :labels

    def initialize(columns = [], rows, grouping)
      @grouping = grouping
      @rows = rows + ["TOTAL"]
      @columns = treat_columns(columns)
      @labels = @columns.map(&:label)
    end

    private


    def treat_columns(columns)
      columns.map! do |col|
        if col[:column_type] == 'combined'
          Kpis::CombinedColumn.new(col)
        else
          Kpis::Column.new(col.merge(grouping: @grouping))
        end
      end
      columns.map! do |col|
        if col.is_a?(Kpis::CombinedColumn)
          col.columns = columns.find_all { |col2| col.columns.include?(col2.label) }.sort do |column|
            col.columns.index(column.label)
          end
        end
        col
      end
    end
  end
end