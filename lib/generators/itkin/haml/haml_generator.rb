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

      def add_helpers
        append_file 'app/helpers/application_helper' do
          <<-STR
          def flash_message
            if not flash[:notice].blank?
              content_tag :div, flash[:notice], :class => 'flash notice'
            elsif not flash[:error].blank?
              content_tag :div, flash[:notice], :class => 'flash error'
            end
          end

          def update_ajax_multipart_item(instance)
            instance_name = instance.class.name.downcase
            raw <<-END
            var $elt = $('##{instance_name}_#{instance.id}')\;
            $elt.find('.header-content').html($('#{render_js :partial => 'item', :locals => { instance_name.to_sym => instance }}').children().first().html())\;
            $elt.children().last().html('#{render_js(:partial => instance)}')\;
            $('.#{instance_name.pluralize}').ajaxAccordion('activate', $('##{instance_name}_#{instance.id}').index())\;
            END
          end
          STR
        end
      end

    end
end