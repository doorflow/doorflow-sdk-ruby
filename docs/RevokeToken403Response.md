# DoorFlow::RevokeToken403Response

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **error** | **String** |  | [optional] |
| **error_description** | **String** |  | [optional] |

## Example

```ruby
require 'doorflow-api'

instance = DoorFlow::RevokeToken403Response.new(
  error: unauthorized_client,
  error_description: You are not authorized to revoke this token
)
```

