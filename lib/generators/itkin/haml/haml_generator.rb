require 'rails/generators/erb'
require 'rails/generators/resource_helpers'



module Itkin
    class HamlGenerator < Rails::Generators::NamedBase
      include Rails::Generators::ResourceHelpers

      argument :attributes, :type => :array, :default => [], :banner => "field:type field:type"

      source_root File.expand_path('../templates', __FILE__)

      def manifest
        directory '.', File.join("app/views", controller_file_path)
      end

    end
end