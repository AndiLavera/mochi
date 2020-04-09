module Mochi::Helpers
  module FlashHandler
    def flash_danger(str)
      flash[:danger] = str
    end

    def flash_warning(str)
      flash[:warning] = str
    end

    def flash_info(str)
      flash[:info] = str
    end

    def flash_success(str)
      flash[:success] = str
    end
  end
end
