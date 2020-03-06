module Mochi::Helpers
  class RedirectHandler < Redirect
    def to(path)
      redirect path
    end
  end
end
