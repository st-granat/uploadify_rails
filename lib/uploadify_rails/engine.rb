module UploadifyRails
  class Engine < ::Rails::Engine
    isolate_namespace UploadifyRails
    engine_name "uploadify_rails"

    initializer "uploadify_rails.hooks" do
      if Object.const_defined?("Formtastic")
        require "uploadify_rails/hooks/formtastic"
      end
    end

    initializer "uploadify_rails.assets_flash" do |app|
      app.config.assets.paths << app.root.join("vendor", "assets", "flash")
    end

    initializer "uploadify_rails.includers" do |app|
      ActionController::Base.send :include, UploadifyRails::Controllers::Base
      ActiveRecord::Base.send :include, UploadifyRails::Models::Resource
      ActiveRecord::Base.send :include, UploadifyRails::Models::Parent
    end
  end
end
