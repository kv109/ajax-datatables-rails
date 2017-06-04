class UserDatatable < AjaxDatatablesRails::Base

  def_delegators :@view, :check_box_tag, :link_to

  # rubocop:disable Metrics/MethodLength
  def view_columns
    @view_columns ||= {
      check_box:   { source: 'User.id', orderable: false, searchable: false },
      username:    { source: 'User.username' },
      email:       { source: 'User.email' },
      first_name:  { source: 'User.first_name' },
      last_name:   { source: 'User.last_name' },
    }
  end
  # rubocop:enable Metrics/MethodLength


  # rubocop:disable Metrics/MethodLength
  def data
    records.map do |record|
      {
        check_box:    record_check_box(record),
        username:     link_to(record.username, record),
        email:        record.email,
        first_name:   record.first_name,
        last_name:    record.last_name,
        'DT_RowId' => record.id,
      }
    end
  end
  # rubocop:enable Metrics/MethodLength


  def get_raw_records
    User.all
  end


  private


    def record_check_box(record, opts = {})
      css = opts.delete(:class) { "#{record.class.name.pluralize.underscore}-checkbox" }
      css = "checkbox #{css}"
      check_box_tag 'ids[]', record.id, false, opts.merge(id: "id_#{record.id}", class: css)
    end

end
