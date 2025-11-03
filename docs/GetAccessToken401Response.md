# DoorFlow::GetAccessToken401Response

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **error** | **String** |  | [optional] |
| **error_description** | **String** |  | [optional] |

## Example

```ruby
require 'doorflow-api'

instance = DoorFlow::GetAccessToken401Response.new(
  error: invalid_client,
  error_description: Client authentication failed
)
```

