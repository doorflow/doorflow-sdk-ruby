# DoorFlow::GetAdmissionRequest403Response

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **error** | **String** |  | [optional] |
| **error_description** | **String** |  | [optional] |

## Example

```ruby
require 'doorflow-api'

instance = DoorFlow::GetAdmissionRequest403Response.new(
  error: forbidden,
  error_description: You are not authorized to access this resource
)
```

