module Mochi::Helpers
  class FlashHandler < Flash
    def danger(str)
      flash.danger = str
    end

    def warning(str)
      flash.info = str
    end

    def info(str)
      flash.info = str
    end

    def success(str)
      flash.success = str
    end
  end
end