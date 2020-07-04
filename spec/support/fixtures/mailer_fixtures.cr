class Mochi::DefaultMailer < Mochi::Mailer
  {% for klass in USER_CLASSES %}
    {% for i in ["confirmation", "reset_password", "unlock", "invitation"] %}
      def {{i.id}}_instructions(record : {{klass}}, token : String, *opts)
        true
      end
    {% end %}
  {% end %}
end

# Some tests require a ConfirmationMailer class
# This is just an empty class to prevent undefined errors
{% for name in MAILER_CLASSES %}
  class {{name.id}}
    def initialize(name : String, email : String, token : String)
    end

    def deliver
      true
    end
  end
{% end %}
