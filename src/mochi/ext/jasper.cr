require "jasper_helpers"

module Mochi::Helpers
  abstract class Render
    include JasperHelpers::Links
    include JasperHelpers::Tags
    include JasperHelpers::Text
    include JasperHelpers::Forms
  end
end
