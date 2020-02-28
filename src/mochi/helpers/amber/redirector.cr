module Mochi::Helpers
  class Redirector < BaseRedirector
    def to(path)
      redirect_to path
    end
  end
end