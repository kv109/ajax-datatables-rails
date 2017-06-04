class UserDatatable < AjaxDatatablesRails::Base

  def_delegators :@view, :check_box_tag, :link_to, :edit_user_path

  # rubocop:disable Metrics/MethodLength
  def view_columns
    @view_columns ||= {
      check_box:   { source: 'User.id', orderable: false, searchable: false },
      username:    { source: 'User.username' },
      email:       { source: 'User.email' },
      first_name:  { source: 'User.first_name' },
      last_name:   { source: 'User.last_name' },
      actions:     { source: 'User.id', searchable: false },
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
        actions:      render_record_actions(record),
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


    def render_record_actions(record)
      links = []
      links << link_to('Edit', edit_user_path(record))
      links << link_to('Delete', record, method: :delete, data: { confirm: 'Are you sure?' })
      links.join(' ').html_safe
    end

end
