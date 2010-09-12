#require 'bundler'
#require 'bundler/cli'

module Itkin

  class ConfigGenerator < Rails::Generators::Base

    source_root File.expand_path('../templates', __FILE__)

    def add_gems
      gem "jquery-rails"
      gem "compass"
      gem "haml"
#      ::Bundler.definition(true)
#      ::Bundler::CLI.new.install
      invoke "jquery:install",[], :ui => true, :force => true
    end

    def add_plugins
      plugin "dynamic_form", :git => "git://github.com/rails/dynamic_form.git", :submodule => true
      plugin "exception_notification", :git =>  "git://github.com/sickill/exception_notification.git", :submodule => true
      plugin "labelled_form_for", :git => "git://github.com/itkin/labelled_form_for.git", :submodule => true
      plugin "javascript_stuff", :git => "git://github.com/itkin/javascript_stuff.git", :submodule => true

      plugin "constants_in_db",  :git => "git://github.com/itkin/constants_in_db.git", :submodule => true

      if yes? "Install social icon ?"
        plugin "social_icons", :git => "git://github.com/itkin/social_icons.git", :submodule => true
      end

      git "submodule init"
    end

    def run_plugin_generators
      invoke 'javascript_stuff'
    end

    def instructions
      say <<-END

  # Run bundle install

  # Run : compass init rails . --using blueprint/semantic

  # Don't forget to add javascript defaults file in : config.action_view.javascript_expansions




      END
    end

  end

end