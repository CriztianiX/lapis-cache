# lapis-cache
## Cache engines for lapis framework

In your config.lua add:
```lua
cache = {
  my_cache = {
    engine = "redis"
  }
}
```

Inside you application
```lua
local Cache = require("lapis.cache.cache")
```

##### Writing to a Cache
###### Cache:write(key, value, config = 'default')
Cache:write() will write a "value" to the Cache.
You can read or delete this value later by referring to it by "key".
You may specify an optional configuration to store the cache in as well. If no "config" is specified, default will be used.
```lua
local posts = Cache:read('posts')
if not posts then
    posts = Posts:select("where id > ?", 0)
    Cache:write('posts', posts)
end
```

##### Read Through Caching
###### Cache:remember(key, callable, config = 'default')
Cache makes it easy to do read-through caching. 
If the named cache key exists, it will be returned. 
If the key does not exist, the callable will be invoked and the results stored in the cache at the provided key.
```lua
local posts = Cache:remember('posts', function()
  return Posts:select("where id > ?", 0)
end)
```

##### Reading From a Cache
###### Cache:read(key, config = 'default')
Cache::read() is used to read the cached value stored under "key" from the "config".
If "config" is null the default config will be used. 
Cache:read() will return the cached value if it is a valid cache or false if the cache has expired or doesn’t exist.
```lua
local cloud = Cache:read('cloud')
```

##### Deleting From a Cache
###### Cache:delete(key, config = 'default')
Cache:delete() will allow you to completely remove a cached object from the store

```lua
-- Remove a key
Cache:delete('my_key')
```
