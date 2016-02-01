require 'rails/generators'
require 'rails/generators/named_base'

module Redsys
  module Generators
    class NotificationsGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)

      def copy_controller
        template "controllers/notifications_controller.rb", "app/controllers/redsys/notifications_controller.rb"
      end

      def add_routes
        route "post 'redsys/notification' => 'redsys/notifications#notification', as: :redsys_notification"
      end
    end
  end
end