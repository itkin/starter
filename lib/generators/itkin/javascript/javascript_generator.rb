module Itkin
  class JavascriptGenerator < Rails::Generators::Base
    desc "A set a custom js widget and functions"
    source_root File.expand_path('../templates', __FILE__)

    def create_lib
      directory 'lib', 'public/javascripts/lib'
    end

    def copy_admin_exemple
      template 'admin.js', 'public/javascripts/admin-exemple.js'
    end
  end
end