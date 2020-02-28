module Mochi::Helpers
  class Contract
    getter render
    getter params
    getter flash
    getter redirect

    def initialize(controller)
      @render = Renderer.new(controller)
      @params = Params.new(controller)
      @flash = Flasher.new(controller)
      @redirect = Redirector.new(controller)
    end
  end
end