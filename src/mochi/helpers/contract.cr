module Mochi::Helpers
  class Contract
    getter render
    getter params
    getter flash
    getter redirect

    def initialize(controller, router)
      if router == :amber
        @render = AmberRender.new(controller)
        @params = AmberParams.new(controller)
        @flash = AmberFlash.new(controller)
        @redirect = AmberRedirection.new(controller)
      else raise Exception.new("We should never reach here: #{router}")
      end
    end
  end

  class AmberRender
    include Amber::Controller::Helpers::Render

    def initialize(c : UserController)
      @controller = c
    end

    def user_new
      render("user/new.ecr")
    end

    def user_show
      render("user/new.ecr")
    end

    def user_edit
      render("user/edit.ecr")
    end

    private macro render_template(filename, path = "src/views")
      Kilt.render("#{{{path}}}/{{filename.id}}")
    end

    forward_missing_to @controller
  end

  class AmberParams
    def initialize(c : UserController)
      @controller = c
    end

    def validate
      resource_params.validate!
    end

    def find_param(param)
      resource_params.validate![param]
    end

    forward_missing_to @controller
  end

  class AmberFlash
    def initialize(c : UserController)
      @controller = c
    end

    def danger(str)
      flash[:danger] = str
    end

    def warning(str)
      flash[:warning] = str
    end

    def info(str)
      flash[:info] = str
    end

    def success(str)
      flash[:success] = str
    end

    forward_missing_to @controller
  end

  class AmberRedirection
    def initialize(c : UserController)
      @controller = c
    end

    def to(path)
      redirect_to path
    end

    forward_missing_to @controller
  end
end