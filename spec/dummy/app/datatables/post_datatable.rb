class PostDatatable < AjaxDatatablesRails::Base

  def_delegators :@view, :check_box_tag, :link_to, :edit_post_path

  # rubocop:disable Metrics/MethodLength
  def view_columns
    @view_columns ||= {
      check_box: { source: 'Post.id', orderable: false, searchable: false },
      title:     { source: 'Post.title' },
      content:   { source: 'Post.content' },
      user_id:   { source: 'Post.user_id' },
      actions:   { source: 'Post.id', searchable: false },
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
        actions:   render_record_actions(record),
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


    def render_record_actions(record)
      links = []
      links << link_to('Edit', edit_post_path(record))
      links << link_to('Delete', record, method: :delete, data: { confirm: 'Are you sure?' })
      links.join(' ').html_safe
    end

end
