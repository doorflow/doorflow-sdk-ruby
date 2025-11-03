# DoorFlow::GetAdmissionRequest401Response

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **error** | **String** |  | [optional] |
| **error_description** | **String** |  | [optional] |

## Example

```ruby
require 'doorflow-api'

instance = DoorFlow::GetAdmissionRequest401Response.new(
  error: unauthorized,
  error_description: The access token is invalid
)
```

