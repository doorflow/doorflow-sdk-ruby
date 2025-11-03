# DoorFlow::AdmitPerson403Response

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **error** | **String** |  | [optional] |
| **reason** | **String** | Reason for denial | [optional] |

## Example

```ruby
require 'doorflow-api'

instance = DoorFlow::AdmitPerson403Response.new(
  error: Access denied,
  reason: Person does not have valid credentials for this channel
)
```

