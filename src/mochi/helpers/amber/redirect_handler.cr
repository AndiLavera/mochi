module Mochi::Helpers
  class RedirectHandler < Redirect
    def to(path)
      redirect_to path
    end
  end
end
