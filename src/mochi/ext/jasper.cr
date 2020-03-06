require "jasper_helpers"

module Mochi::Helpers
  abstract class Render
    include JasperHelpers::Links
  end
end
