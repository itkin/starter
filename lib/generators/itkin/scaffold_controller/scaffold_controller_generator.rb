require 'rails/generators/rails/scaffold_controller/scaffold_controller_generator'

module Itkin
  class ScaffoldControllerGenerator < Rails::Generators::ScaffoldControllerGenerator
    source_root File.expand_path('../templates', __FILE__)

    remove_hook_for :template_engine

    hook_for :template_engine, :in => :itkin

  end
end