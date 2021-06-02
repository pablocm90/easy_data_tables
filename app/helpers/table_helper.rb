# frozen_string_literal: true

# Creates and exposes the helper method
module TableHelper
  def easy_data_table(columns, label, grouping)
    data_table = DataTable.new(
      columns,
      label,
      grouping
    )
    render 'easy_data_tables/data_table', data_table: data_table
  end
end
