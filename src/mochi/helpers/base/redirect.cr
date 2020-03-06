module Mochi::Helpers
  abstract class Redirect
    def initialize(c : UserController)
      @controller = c
    end

    def initialize(c : SessionController)
      @controller = c
    end

    abstract def to(path)

    forward_missing_to @controller
  end
end
