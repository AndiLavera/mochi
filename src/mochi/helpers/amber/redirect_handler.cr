module Mochi::Helpers
  module Amber
    module RedirectHandler
      macro to(path)
        redirect_to {{path}}
      end
    end
  end
end
