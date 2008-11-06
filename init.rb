# Include hook code here
require 'rails_pandoc'
config.after_initialize do
  # Include our helper into every view
  ActionView::Base.send :include, PandocHelper
end

