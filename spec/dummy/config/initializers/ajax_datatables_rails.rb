AjaxDatatablesRails.configure do |c|
  c.db_adapter = ActiveRecord::Base.connection.adapter_name.downcase.to_sym
  c.orm = :active_record
end
