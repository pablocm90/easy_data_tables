require "easy_data_tables/version"

if defined?(ActiveSupport.on_load)
  ActiveSupport.on_load(:action_view) do
    include EasyDataTables::Helper
  end
end

module EasyDataTables
  class Error < StandardError; end
  
end
