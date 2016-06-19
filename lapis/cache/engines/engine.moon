util = require("lapis.util")

return class EngineCache
  @encode: (value) =>
    unless value
      error("value missing")
    util.to_json(value)

  @decode: (value) =>
    unless value
      error("value missing")
    util.from_json(value)

  @set_config: (config) =>
    @config = config
    return @
  
  @write:(key, value) =>
    error("write is delegated to engine")