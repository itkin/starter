module Itkin
  class SassGenerator < Rails::Generators::Base
    desc "A set a custom sass mixin"
    source_root File.expand_path('../templates', __FILE__)

    def copy_partial_repo
      directory 'itkin', 'stylesheets/partials/itkin'
    end

    def copy_admin_example
      template 'admin_exemple.sass', 'stylesheets/admin_exemple.sass'
    end
  end
end