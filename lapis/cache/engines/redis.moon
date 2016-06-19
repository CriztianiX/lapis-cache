EngineCache = require("lapis.cache.engines.engine")

class DefaultEngine extends EngineCache
  connection = ->
    redis = require("redis")
    redis.connect(@config.host or "127.0.0.1", @config.port or 6379)

  @read: (key) =>
    conn = connection!
    value = conn\get key
    @decode value

  @write: (key, value) =>
    value = @encode(value)
    conn = connection!
    conn\set key, value

return DefaultEngine