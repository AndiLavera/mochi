module Mochi::Helpers
  class Contract
    getter render
    getter params
    getter flash
    getter redirect
    getter session

    def initialize(controller)
      @render = RenderHandler.new(controller)
      @params = ParamsHandler.new(controller)
      @flash = FlashHandler.new(controller)
      @redirect = RedirectHandler.new(controller)
      @session = SessionHandler.new(controller)
    end
  end
end
