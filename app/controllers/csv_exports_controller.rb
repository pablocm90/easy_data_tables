# frozen string literal: true

require_dependency "easy_data_tables/application_controller"

module EasyDataTables
  class CsvExportsController < ApplicationController
    def export
      p 'I am here'
    end
  end
end