require "./mochi/configuration"

# TODO: Write documentation for `Mochi`
module Mochi
  @@configuration = Mochi::Configuration.new

  def self.configuration
    @@configuration
  end

  def self.setup
    yield @@configuration
  end

  macro mochi_granite(*modules)
    {% for i in modules %}
      {% if i.id == :authenticable %}
        include Mochi::Models::Authenticable::Validations::Granite
        include Mochi::Models::Authenticable
        with_validations
      {% end %}

      {% if i.id == :confirmable %}
        include Mochi::Models::Confirmable
        with_confirmation
      {% end %}

      {% if i.id == :trackable %}
        include Mochi::Models::Trackable
      {% end %}

      {% if i.id == :recoverable %}
        include Mochi::Models::Recoverable
      {% end %}

      {% if i.id == :omniauthable %}
        #include Mochi::Omniauthable::Providers
      {% end %}
    {% end %}
  end

  macro mochi_jennifer(*modules)
    {% for i in modules %}
      {% if i.id == :authenticable %}
        include Mochi::Models::Authenticable::Validations::Jennifer
        include Mochi::Models::Authenticable
        jennifer_validations
      {% end %}

      {% if i.id == :confirmable %}
        include Mochi::Models::Confirmable
        with_confirmation
      {% end %}

      {% if i.id == :trackable %}
        include Mochi::Models::Trackable
      {% end %}

      {% if i.id == :recoverable %}
        include Mochi::Models::Recoverable
      {% end %}

      {% if i.id == :omniauthable %}
        #include Mochi::Omniauthable::Providers
      {% end %}
    {% end %}
  end
end
