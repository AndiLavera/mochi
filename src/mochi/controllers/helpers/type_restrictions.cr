module Mochi::Controllers::Helpers
  module TypeRestrictions
    macro confirmable?
      user.is_a? Mochi::Models::Confirmable
    end

    macro lockable?
      user.is_a? Mochi::Models::Lockable
    end

    macro recoverable?
      user.is_a? Mochi::Models::Recoverable
    end

    macro trackable?
      user.is_a? Mochi::Models::Trackable
    end
  end
end
