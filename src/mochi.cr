require "./mochi/configuration"

module Mochi
  @@configuration = Mochi::Configuration.new

  # Access mochi configurations.
  #
  # `Mochi.configuration.reconfirmable # => true`
  def self.configuration
    @@configuration
  end

  # Main method for configuring mochi.
  # Usage:
  #
  # ```
  # Mochi.setup do |config|
  #   config.property = X
  # end
  # ```
  def self.setup
    yield @@configuration
  end

  # Macro method for easily including all neccessary files for a particular module.
  #
  # `mochi_granite(:authenticable, :confirmable)`
  macro mochi_granite(*modules)
    {% for i in modules %}
      {% if i.id == :authenticable %}
        include Mochi::Models::Validations::Granite
        include Mochi::Models::Authenticable
        include Mochi::Models::Query::Granite
      {% end %}

      {% if i.id == :confirmable %}
        include Mochi::Models::Confirmable
      {% end %}

      {% if i.id == :trackable %}
        include Mochi::Models::Trackable
      {% end %}

      {% if i.id == :recoverable %}
        include Mochi::Models::Recoverable
      {% end %}

      {% if i.id == :lockable %}
        include Mochi::Models::Lockable
      {% end %}

      {% if i.id == :invitable %}
        include Mochi::Models::Invitable
      {% end %}

      {% if i.id == :omniauthable %}
        #include Mochi::Omniauthable::Providers
      {% end %}
    {% end %}
  end

  # Macro method for easily including all neccessary files for a particular module.
  #
  # `mochi_jennifer(:authenticable, :confirmable)`
  macro mochi_jennifer(*modules)
    {% for i in modules %}
      {% if i.id == :authenticable %}
        include Mochi::Models::Validations::Jennifer
        include Mochi::Models::Authenticable
        include Mochi::Models::Query::Jennifer
      {% end %}

      {% if i.id == :confirmable %}
        include Mochi::Models::Confirmable
      {% end %}

      {% if i.id == :trackable %}
        include Mochi::Models::Trackable
      {% end %}

      {% if i.id == :recoverable %}
        include Mochi::Models::Recoverable
      {% end %}

      {% if i.id == :lockable %}
        include Mochi::Models::Lockable
      {% end %}

      {% if i.id == :invitable %}
        include Mochi::Models::Invitable
      {% end %}

      {% if i.id == :omniauthable %}
        #include Mochi::Omniauthable::Providers
      {% end %}
    {% end %}
  end
end
