class PostDatatable < AjaxDatatablesRails::Base

  def_delegators :@view, :check_box_tag, :link_to

  # rubocop:disable Metrics/MethodLength
  def view_columns
    @view_columns ||= {
      check_box: { source: 'Post.id', orderable: false, searchable: false },
      title:     { source: 'Post.title' },
      content:   { source: 'Post.content' },
      user_id:   { source: 'Post.user_id' },
    }
  end
  # rubocop:enable Metrics/MethodLength


  # rubocop:disable Metrics/MethodLength
  def data
    records.map do |record|
      {
        check_box: record_check_box(record),
        title:     link_to(record, record),
        content:   record.content,
        user_id:   link_to(record.user, record.user),
        'DT_RowId' => record.id,
      }
    end
  end
  # rubocop:enable Metrics/MethodLength


  def get_raw_records
    Post.includes(:user).all
  end


  private


    def record_check_box(record, opts = {})
      css = opts.delete(:class) { "#{record.class.name.pluralize.underscore}-checkbox" }
      css = "checkbox #{css}"
      check_box_tag 'ids[]', record.id, false, opts.merge(id: "id_#{record.id}", class: css)
    end

end
