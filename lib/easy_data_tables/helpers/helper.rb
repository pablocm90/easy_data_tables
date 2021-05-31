# frozen_string_literal: true

module EasyDataTables
  module Helper
    def easy_data_table(columns, label, grouping)
      data_table = Kpis::DataTable.new(
        columns,
        label,
        grouping
      )
      render "data_table"
    end
  end
end