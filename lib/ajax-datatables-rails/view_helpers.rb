module AjaxDatatablesRails
  module ViewHelpers

    DATATABLE_BUTTONS = {
      csv: {
        label: 'datatables.buttons.csv',
        icon: 'fa-file-text-o',
        opts: { extend: 'csv' }
      },
      excel: {
        label: 'datatables.buttons.excel',
        icon: 'fa-file-excel-o',
        opts: { extend: 'excel' }
      },
      pdf: {
        label: 'datatables.buttons.pdf',
        icon: 'fa-file-pdf-o',
        opts: { extend: 'pdf' }
      },
      print: {
        label: 'datatables.buttons.print',
        icon: 'fa-print',
        opts: { extend: 'print' }
      }
    }.freeze


    def datatable_button_for(button)
      button = button.to_sym
      label  = DATATABLE_BUTTONS[button][:label]
      icone  = DATATABLE_BUTTONS[button][:icon]
      opts   = DATATABLE_BUTTONS[button][:opts]
      opts.merge(text: content_tag(:i, "fa #{icone}"), titleAttr: t(label))
    end


    def datatable_dom_with_selected_and_buttons(css_class = nil)
      "<\"html5buttons\"B>#{datatable_dom_with_selected(css_class)}"
    end


    def datatable_dom_with_selected(css_class = nil)
      "lr<\"clearfix\"><\"dataTables_info selected-count-wrapper #{css_class}\"<\".selected-count\">><\"#{css_class}\" i>tp"
    end


    def datatable_length_menu
      [DATATABLE_LENGTH_MENU, DATATABLE_LENGTH_MENU]
    end


    def bootstrap_datatables_for(id, opts = {}, &block)
      opts = { html: { width: '100%', class: 'table table-striped table-bordered display responsive no-wrap' } }.merge(opts)
      datatable_for(id, opts, &block)
    end


    def datatable_for(id, opts = {}, &block)
      datatable = AjaxDatatablesRails::Presenters::DatatablePresenter.new(self, id, opts)
      yield datatable if block_given?
      datatable
    end


    def link_to_select_all(selector)
      function = "toggleCheckboxes(this, '#{selector}'); return false;"
      opts = { onchange: function, title: "#{t('button.check_all')}/#{t('button.uncheck_all')}" }
      check_box_tag('select_all', '1', false, opts)
    end

  end
end
