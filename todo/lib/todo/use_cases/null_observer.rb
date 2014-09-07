module Todo
  module UseCases
    class NullObserver
      def use_case_succeeded(*); end
      def validation_failed(*); end
    end
  end
end
