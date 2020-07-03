class Mochi::DefaultMailer < Mochi::Mailer
  {% for klass in USER_CLASSES %}
    {% for i in ["confirmation", "reset_password", "unlock", "invitation"] %}
      def {{i.id}}_instructions(record : {{klass}}, token : String, *opts)
        true
      end
    {% end %}
  {% end %}
end
