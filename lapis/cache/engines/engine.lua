local util = require("lapis.util")
local EngineCache
do
  local _base_0 = { }
  _base_0.__index = _base_0
  local _class_0 = setmetatable({
    __init = function() end,
    __base = _base_0,
    __name = "EngineCache"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  local self = _class_0
  self.encode = function(self, value)
    if not (value) then
      error("value missing")
    end
    return util.to_json(value)
  end
  self.decode = function(self, value)
    if not (value) then
      error("value missing")
    end
    return util.from_json(value)
  end
  self.set_config = function(self, config)
    self.config = config
    return self
  end
  self.write = function(self, key, value)
    return error("write is delegated to engine")
  end
  EngineCache = _class_0
  return _class_0
end
