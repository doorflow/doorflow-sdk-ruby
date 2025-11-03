# DoorFlow::GetTokenInfo401Response

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **error** | **String** |  | [optional] |
| **error_description** | **String** |  | [optional] |

## Example

```ruby
require 'doorflow-api'

instance = DoorFlow::GetTokenInfo401Response.new(
  error: invalid_token,
  error_description: The access token is invalid or has expired
)
```

