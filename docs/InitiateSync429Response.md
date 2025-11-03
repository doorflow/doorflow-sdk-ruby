# DoorFlow::InitiateSync429Response

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **error** | **String** | Error code indicating rate limiting |  |
| **description** | **String** | Human-readable description of the rate limit |  |
| **retry_in** | **Integer** | Number of seconds to wait before retrying |  |

## Example

```ruby
require 'doorflow-api'

instance = DoorFlow::InitiateSync429Response.new(
  error: rate_limited,
  description: Sync rate limit exceeded. Please wait before trying again.,
  retry_in: 60
)
```

