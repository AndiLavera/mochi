module Mochi::Helpers
  abstract class BaseRedirector
    def initialize(c : UserController)
      @controller = c
    end

    abstract def to(path)

    forward_missing_to @controller
  end
end