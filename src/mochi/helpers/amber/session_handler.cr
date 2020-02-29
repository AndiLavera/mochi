module Mochi::Helpers
  class SessionHandler < Session
    def create(key, value)
      session[key] = value
    end

    def destroy(key)
      session.delete(key)
    end
  end
end