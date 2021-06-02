# frozen_string_literal: true

EasyDataTables::Engine.routes.draw do
  ressources :csv_exports
  # get '/export', to: 'csv_exports_controller#export', as: 'csv_export'
end
