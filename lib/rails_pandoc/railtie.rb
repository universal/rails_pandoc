module RailsPandoc
  class Railtie < ::Rails::Railtie
    config.rails_pandoc = ActiveSupport::OrderedOptions.new
    initializer "rails_pandoc.railtie.configure" do |app|
      ActiveSupport.on_load :action_view do
        include RailsPandoc::PandocHelper
      end
      #ActionView::Base.send :include, RailsPandoc::PandocHelper
      # set paths...
      # include....
    end
  end
end