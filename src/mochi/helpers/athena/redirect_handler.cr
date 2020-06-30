module Mochi::Helpers
  module Athena
    module RedirectHandler
      def to(path)
        ART::RedirectResponse.new path
      end
    end
  end
end
