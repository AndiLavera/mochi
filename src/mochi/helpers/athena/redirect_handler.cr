module Mochi::Helpers
  class RedirectHandler < Redirect
    def to(path)
      ART::RedirectResponse.new path
    end
  end
end
