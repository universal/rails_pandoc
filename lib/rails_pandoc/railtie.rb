module RailsPandoc
  class Railtie < ::Rails::Railtie
    config.rails_pandoc = ActiveSupport::OrderedOptions.new
    initializer "rails_pandoc.railtie.configure" do |app|
      ActiveSupport.on_load :action_view do
        include RailsPandoc::PandocHelper
      end
      RailsPandoc::Config.executable = app.config.rails_pandoc.executable if app.config.rails_pandoc.executable
      RailsPandoc::Config.sanitize_executable = app.config.rails_pandoc.sanitize_executable if app.config.rails_pandoc.sanitize_executable
    end
  end
end