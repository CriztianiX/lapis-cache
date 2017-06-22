package = "lapis-cache"
version = "scm-0"

source = {
  url = "https://github.com/CriztianiX/lapis-cache"
}

description = {
  summary = "Cache engines for Lapis Framework",
  homepage = "https://github.com/CriztianiX/lapis-cache",
  maintainer = "Cristian Haunsen <cristianhaunsen@gmail.com>",
  license = "MIT"
}

dependencies = {
  "lua ~> 5.1",
  "lapis",
  "redis-lua"
}

build = {
  type = "builtin",
  modules = {
    ["lapis.cache.cache"] = "lapis/cache/cache.lua",
    ["lapis.cache.engines.engine"] = "lapis/cache/engines/engine.lua",
    ["lapis.cache.engines.redis"] = "lapis/cache/engines/redis.lua",
  }
}
