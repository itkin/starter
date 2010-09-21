require 'rails/generators/rails/scaffold/scaffold_generator'

module Itkin
  class ScaffoldGenerator < Rails::Generators::NamedBase
    desc "Itkin custom ajax scaffold"

    include Rails::Generators::ResourceHelpers

    source_root File.expand_path('../templates', __FILE__)

    argument :attributes, :type => :array, :default => [], :banner => "field:type field:type"
    class_option :orm, :type => :boolean, :default => true
    class_option :migration,  :type => :boolean
    class_option :timestamps, :type => :boolean
    class_option :parent,     :type => :string, :desc => "The parent class for the generated model"

    def create_migration_file
      return unless options[:migration] && options[:parent].nil?
      migration_template "migration.rb", "db/migrate/create_#{table_name}.rb"
    end

    def create_model_file
      template 'model.rb', File.join('app/models', class_path, "#{file_name}.rb")
    end

    def create_controller_file
      template 'controller.rb', File.join('app/controllers', class_path, "#{controller_file_name}_controller.rb")
    end

    def create_helper_file
      template 'helper.rb', File.join('app/helpers', class_path, "#{controller_file_name}_helper.rb")
    end

    def create_unit_test_file
      template 'test/unit.rb', File.join('test/unit', "#{file_name}_test.rb")
    end

    def create_functional_test_file
      template 'test/functional.rb', File.join('test/functional', class_path, "#{file_name}_test.rb")
    end

    def create_fixtures_file
      template 'test/fixtures.yml', File.join('test/fixtures', "#{file_name.pluralize}.yml")
    end


  end
end