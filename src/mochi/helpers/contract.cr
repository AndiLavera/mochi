require "./**"

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
      include Helpers::Athena::RenderHandler
      include Helpers::Athena::ParamsHandler
      include Helpers::Athena::FlashHandler
      include Helpers::Athena::RedirectHandler
      include Helpers::Athena::SessionHandler
    end

    module Lucky
      include Helpers::Lucky::RenderHandler
      include Helpers::Lucky::ParamsHandler
      include Helpers::Lucky::FlashHandler
      include Helpers::Lucky::RedirectHandler
      include Helpers::Lucky::SessionHandler
    end

    module Jennifer
      include Helpers::Jennifer::QueryHandler
    end

    module Granite
      include Helpers::Granite::QueryHandler
    end
  end
end
