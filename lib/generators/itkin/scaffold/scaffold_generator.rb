require 'rails/generators/rails/scaffold/scaffold_generator'

module Itkin
  class ScaffoldGenerator < Rails::Generators::ScaffoldGenerator
    desc "Itkin custom scaffold"
    source_root File.expand_path('../templates', __FILE__)

    remove_hook_for :scaffold_controller
    hook_for :scaffold_controller, :in => :itkin, :required => true
  end
end