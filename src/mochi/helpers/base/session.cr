module Mochi::Helpers
  abstract class Session
    def initialize(c : UserController)
      @controller = c
    end

    def initialize(c : SessionController)
      @controller = c
    end

    abstract def create(key, value)
    abstract def destroy(key)

    forward_missing_to @controller
  end
end