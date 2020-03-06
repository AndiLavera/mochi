module Mochi::Helpers
  abstract class Flash
    def initialize(c : UserController)
      @controller = c
    end

    def initialize(c : SessionController)
      @controller = c
    end

    abstract def danger(str)
    abstract def warning(str)
    abstract def info(str)
    abstract def success(str)

    forward_missing_to @controller
  end
end
