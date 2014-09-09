module Todo
  module Entities
    class Todo
      attr_reader :description

      def initialize(description: nil)
        @description = description
      end
    end
  end
end
