module Mochi::Helpers
  module Contract
    include Helpers::RenderHandler
    include Helpers::ParamsHandler
    include Helpers::FlashHandler
    include Helpers::RedirectHandler
    include Helpers::SessionHandler
  end
end
