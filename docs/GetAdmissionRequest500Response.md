# DoorFlow::GetAdmissionRequest500Response

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **error** | **String** |  | [optional] |
| **error_description** | **String** |  | [optional] |

## Example

```ruby
require 'doorflow-api'

instance = DoorFlow::GetAdmissionRequest500Response.new(
  error: internal_server_error,
  error_description: An unexpected error occurred
)
```

