module Todo
  module Entities
    class Todo
      attr_reader :description

      def initialize(description: nil)
        @description = description
      end

      def valid?
        failed_validations.empty?
      end

      def failed_validations
        if description_is_just_whitespace?
          ["description must be present"]
        else
          []
        end
      end

      def do!
        @state = "done"
      end

      def done?
        @state == "done"
      end

      private
      def description_is_just_whitespace?
        description.to_s.strip.empty?
      end
    end
  end
end
