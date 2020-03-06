module Mochi::Helpers
  class RenderHandler < Render
    macro render(template = nil, layout = true, partial = nil, path = "spec/support/views", folder = __FILE__)
      {% if !(template || partial) %}
        raise "Template or partial required!"
      {% end %}

      {{ filename = template || partial }}

      # Render Template and return content
      {% if filename.id.split("/").size > 1 %}
        %content = render_template("#{{{filename}}}", {{path}})
      {% else %}
        {{ short_path = folder.gsub(/^.+?(?:controllers|views)\//, "") }}
        {% if folder.id.ends_with?(".ecr") %}
          %content = render_template("#{{{short_path.gsub(/\/[^\.\/]+\.ecr/, "")}}}/#{{{filename}}}", {{path}})
        {% else %}
          %content = render_template("#{{{short_path.gsub(/\_controller\.cr|\.cr/, "")}}}/#{{{filename}}}", {{path}})
        {% end %}
      {% end %}

      # Render Layout
      {% if layout && !partial %}
        content = %content
        render_template("layouts/#{{{layout.class_name == "StringLiteral" ? layout : LAYOUT}}}", {{path}})
      {% else %}
        %content
      {% end %}
    end
  end
end
