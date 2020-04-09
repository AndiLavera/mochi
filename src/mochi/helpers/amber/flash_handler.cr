module Mochi::Helpers
  # Generates 4 methods for flashing messages
  #
  # Generates `flash_success`, `flash_danger`, `flash_warning`, `flash_info`,
  module FlashHandler
    {% for i in ["success", "danger", "warning", "info"] %}
      macro flash_{{i.id}}(str)
        flash[:{{i.id}}] = \{{str}}
      end
    {% end %}
  end
end
