require 'rails/generators'
require 'rails/generators/named_base'

module Redsys
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)

      def copy_initializer
        template "redsys-rails.rb", "config/initializers/redsys-rails.rb"
      end
    end
  end
end

