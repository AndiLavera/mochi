module Mochi::Helpers
  class Redirector < BaseRedirector
    def to(path)
      redirect path
    end
  end
end