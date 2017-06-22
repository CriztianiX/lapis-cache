local config = require("lapis.config")

config({"development", "test", "production"}, {
  cache = {
    default = {
      engine = "file"
    },
    redis = {
      engine = "redis"
    }
  }
})

config("test", {
})

config("production", {
})
