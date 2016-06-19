local EngineCache = require("lapis.cache.engines.engine")
local DefaultEngine
do
  local connection
  local _parent_0 = EngineCache
  local _base_0 = { }
  _base_0.__index = _base_0
  setmetatable(_base_0, _parent_0.__base)
  local _class_0 = setmetatable({
    __init = function(self, ...)
      return _parent_0.__init(self, ...)
    end,
    __base = _base_0,
    __name = "DefaultEngine",
    __parent = _parent_0
  }, {
    __index = function(cls, name)
      local val = rawget(_base_0, name)
      if val == nil then
        return _parent_0[name]
      else
        return val
      end
    end,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  local self = _class_0
  connection = function()
    local redis = require("redis")
    return redis.connect(self.config.host or "127.0.0.1", self.config.port or 6379)
  end
  self.read = function(self, key)
    local conn = connection()
    local value = conn:get(key)
    return self:decode(value)
  end
  self.write = function(self, key, value)
    value = self:encode(value)
    local conn = connection()
    return conn:set(key, value)
  end
  if _parent_0.__inherited then
    _parent_0.__inherited(_parent_0, _class_0)
  end
  DefaultEngine = _class_0
end
return DefaultEngine
