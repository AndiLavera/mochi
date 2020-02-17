module Mochi::CLI
  def self.config
    Config.new
  end

  class Config
    SHARD_YML    = "shard.yml"
    DEFAULT_NAME = "[process_name]"

    property database : String = "sqlite"
    property language : String = "ecr"
    property model : String = "jennifer"
    property recipe : (String | Nil) = nil
    property recipe_source : (String | Nil) = nil

    def initialize
    end

    YAML.mapping(
      database: {type: String, default: "sqlite"},
      language: {type: String, default: "ecr"},
      model: {type: String, default: "jennifer"},
      recipe: String | Nil,
      recipe_source: String | Nil,
    )

    def self.get_name
      if File.exists?(SHARD_YML) &&
         (yaml = YAML.parse(File.read SHARD_YML)) &&
         (name = yaml["name"]?)
        name.as_s
      else
        DEFAULT_NAME
      end
    end
  end
end
