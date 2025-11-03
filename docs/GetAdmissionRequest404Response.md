# DoorFlow::GetAdmissionRequest404Response

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **error** | **String** |  | [optional] |
| **error_description** | **String** |  | [optional] |

## Example

```ruby
require 'doorflow-api'

instance = DoorFlow::GetAdmissionRequest404Response.new(
  error: not_found,
  error_description: The requested resource was not found
)
```

