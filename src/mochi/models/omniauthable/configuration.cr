module Mochi
  module Omniauthable
    @@configuration = Mochi::Omniauthable::Configuration.new

    def self.make(provider, redirect_uri)
      Mochi::Omniauthable::Engine.new(provider, redirect_uri)
    end

    def self.configuration
      @@configuration
    end

    def self.config(provider, key, secret)
      @@configuration.providers[provider] = [key, secret]
    end

    def self.setup
      yield @@configuration
    end

    class Configuration
      getter providers
      setter providers

      property confirmable_enabled : Bool = false

      property google_id : String = String.new
      property google_secret_key : String = String.new

      property facebook_id : String = String.new
      property facebook_secret_key : String = String.new

      property github_id : String = String.new
      property github_secret_key : String = String.new

      property twitter_id : String = String.new
      property twitter_secret_key : String = String.new

      property vk_id : String = String.new
      property vk_secret_key : String = String.new

      def initialize
        @providers = Hash(String, Array(String)).new
      end

      # Returns the proper keys depending on the provider
      def keys(provider : String)
        case provider
        when "google"
          return google_id, google_secret_key
        when "github"
          return github_id, github_secret_key
        when "facebook"
          return facebook_id, facebook_secret_key
        when "vk"
          return vk_id, vk_secret_key
        when "twitter"
          return twitter_id, twitter_secret_key
        else
          raise "Provider #{provider} not implemented"
        end
      end
    end
  end
end
