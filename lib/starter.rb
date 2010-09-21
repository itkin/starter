#require 'ruby-debug'
#
#Debugger.start
#if Debugger.respond_to?(:settings)
#  Debugger.settings[:autoeval] = true
#  Debugger.settings[:autolist] = 1
#end
#
#module Rails
#  module Generators
#    class ActiveModel
#      def initialize(name)
#        debugger
#        ''
#      end
#    end
#  end
#end