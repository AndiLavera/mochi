require "./amber/*"
module Mochi::Helpers
  module Contract
    module Amber
      include Helpers::Amber::RenderHandler
      include Helpers::Amber::ParamsHandler
      include Helpers::Amber::FlashHandler
      include Helpers::Amber::RedirectHandler
      include Helpers::Amber::SessionHandler
    end

    module Athena
    end

    module Lucky
    end
  end
end
