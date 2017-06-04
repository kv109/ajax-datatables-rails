module AjaxDatatablesRails
  module Presenters
    class DatatablePresenter < SimpleDelegator

      def initialize(view, id, opts = {})
        super(view)
        @view       = view
        @id         = id
        @opts       = opts
        @body_opts  = {}
        @buttons    = []
        @columns    = []
        @js_method  = 'createDatatable'
      end


      def button(opts = {})
        @buttons << opts
      end


      def head_for(column, opts = {})
        @columns << DatatableColumn.new(@view, column, opts)
      end


      def body(opts = {})
        @body_opts = opts
      end


      def js_method(js_method)
        @js_method = js_method
      end


      def render_datatable
        html_opts = @opts.delete(:html) { {} }
        options = html_opts.merge({ id: id, data: datatable_options.merge(@opts) })
        content_tag(:table, table_content, options)
      end


      def render_js_datatable
        raw("#{@js_method}('##{id}');")
      end


      private


        def id
          "#{@id}-table"
        end


        def table_content
          table_header + table_body
        end


        def table_header
          content_tag(:thead, table_header_rows)
        end


        def table_header_rows
          content_tag(:tr, @columns.map(&:to_s).join.html_safe)
        end


        def table_body
          content_tag(:tbody, '', @body_opts)
        end


        def datatable_options
          {
            processing:   true,
            server_side:  true,
            state_save:   true,
            responsive:   true,
            page_length:  10,
            length_menu:  [[10, 25, 50, 100], [10, 25, 50, 100]],
            paging_type:  'simple_numbers',
            dom:          'lfrtip',
            order:        [],
            # language:     datatables_translations,
            columns:      datatable_columns,
            buttons:      @buttons,
          }
        end


        def datatable_columns
          data = []
          @columns.each_with_index do |c, i|
            data << { data: i }.merge(c.to_hash)
          end
          data
        end

    end
  end
end
