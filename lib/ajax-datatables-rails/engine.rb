module AjaxDatatablesRails
  class Engine < ::Rails::Engine
    ActiveSupport.on_load(:action_view){ include AjaxDatatablesRails::ViewHelpers }

    config.before_initialize do
      config.i18n.load_path += Dir[config.root.join('config', 'locales', '*.yml').to_s]
    end
  end
end
