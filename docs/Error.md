# DoorFlow::Error

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **error** | **String** | Error code |  |
| **error_description** | **String** | Human-readable error description |  |

## Example

```ruby
require 'doorflow-api'

instance = DoorFlow::Error.new(
  error: unauthorized,
  error_description: The access token is invalid
)
```

