module Mochi::Helpers
  module RedirectHandler
    macro to(path)
      redirect_to {{path}}
    end
  end
end
