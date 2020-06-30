module Mochi::Helpers
  module Amber
    module RenderHandler
      macro display(view)
        render {{view}}
      end
    end
  end
end
