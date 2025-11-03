# DoorFlow::GetAccessToken400Response

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **error** | **String** |  | [optional] |
| **error_description** | **String** |  | [optional] |

## Example

```ruby
require 'doorflow-api'

instance = DoorFlow::GetAccessToken400Response.new(
  error: invalid_grant,
  error_description: The provided authorization grant is invalid, expired, revoked, or does not match the redirection URI
)
```

