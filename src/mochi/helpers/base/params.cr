module Mochi::Helpers
  abstract class Params
    def initialize(c : UserController)
      @controller = c
    end

    def initialize(c : SessionController)
      @controller = c
    end

    abstract def validate
    abstract def fetch(param)

    forward_missing_to @controller
  end
end
