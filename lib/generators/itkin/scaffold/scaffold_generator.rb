require 'ruby-debug'
Debugger.start
if Debugger.respond_to?(:settings)
  Debugger.settings[:autoeval] = true
  Debugger.settings[:autolist] = 1
end


module Itkin
  class ScaffoldGenerator < Rails::Generators::NamedBase
    desc "Itkin custom ajax scaffold"

    include Rails::Generators::ResourceHelpers
    include Rails::Generators::Migration

    source_root File.expand_path('../templates', __FILE__)

    argument :attributes, :type => :array, :default => [], :banner => "field:type field:type"
    class_option :orm, :type => :boolean, :default => true
    class_option :javascript, :type => :boolean, :default => false
    class_option :stylesheet, :type => :boolean, :default => false
    class_option :migration,  :type => :boolean, :default => true
    class_option :timestamps, :type => :boolean
    class_option :parent,     :type => :string, :desc => "The parent class for the generated model"

    def create_migration_file
      return if not options[:orm] or not options[:migration] or options[:parent]
      migration_template "migration.rb", "db/migrate/create_#{table_name}.rb"
    end

    def create_model_file
      return unless options[:orm]
      template 'model.rb', File.join('app/models',  "#{file_name}.rb")
    end

    def create_fixtures_file
      return unless options[:orm]
      template 'test/fixtures.yml', File.join('test/fixtures', "#{file_name.pluralize}.yml")
    end

    def create_unit_test_file
      return unless options[:orm]
      template 'test/unit.rb', File.join('test/unit', "#{file_name}_test.rb")
    end


    def create_controller_file
      template 'controller.rb', File.join('app/controllers', class_path, "#{controller_file_name}_controller.rb")
    end

    def create_helper_file
      template 'helper.rb', File.join('app/helpers', class_path, "#{controller_file_name}_helper.rb")
    end

    def create_functional_test_file
      template 'test/functional.rb', File.join('test/functional', class_path, "#{controller_file_name}_controller_test.rb")
    end

    def create_view_files
      directory 'views', File.join('app/views', class_path, file_name.pluralize)
    end

    def add_resource_route
      route_config =  class_path.collect{|namespace| "namespace :#{namespace} do " }.join(" ")
      route_config << "resources :#{file_name.pluralize}"
      route_config << " end" * class_path.size
      route route_config
    end

    def create_js_files
      return unless options.javascript
      invoke 'itkin:javascript', [], :force => options.force
    end

    def create_sass_files
      return unless options.stylesheet
      invoke 'itkin:sass', [], :force => options.force
    end

    protected

      def parent_class_name
        options[:parent] || "ActiveRecord::Base"
      end

      def assign_names!(name) #:nodoc:
        super
        @class_name = file_name.camelize
        @class_name_with_namespace = (class_path + [file_name]).map!{ |m| m.camelize }.join('::')
      end

      def class_name
        @class_name
      end

      def class_name_with_namespace
        @class_name_with_namespace
      end

      # Implement the required interface for Rails::Generators::Migration.
      def self.next_migration_number(dirname) #:nodoc:
        next_migration_number = current_migration_number(dirname) + 1
        if ActiveRecord::Base.timestamped_migrations
          [Time.now.utc.strftime("%Y%m%d%H%M%S"), "%.14d" % next_migration_number].max
        else
          "%.3d" % next_migration_number
        end
      end

      def table_name
        @table_name ||= begin
          pluralize_table_names? ? plural_name : singular_name
        end
      end


      def named_route(action=nil, plural=nil)
        if action.to_s == "index" or plural
          (class_path + [plural_name]+['path']).compact.join('_')
        else
          action = nil if ['destroy', 'show'].include?(action.to_s)
          ([action] + class_path + [singular_name]+['path']).compact.join('_')
        end

      end

  end
end