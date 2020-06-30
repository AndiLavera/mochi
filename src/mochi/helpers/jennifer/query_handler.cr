module Mochi::Helpers
  module Jennifer
    module QueryHandler
      macro find_by_email
        User.where { _email == fetch("email") }
      end
    end
  end
end
