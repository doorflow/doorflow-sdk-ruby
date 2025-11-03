# DoorFlow::AdmitPerson202Response

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **admission_request_id** | **Integer** | ID of the admission request for status tracking | [optional] |
| **status** | **String** | Initial status of the admission | [optional] |

## Example

```ruby
require 'doorflow-api'

instance = DoorFlow::AdmitPerson202Response.new(
  admission_request_id: 123456789,
  status: pending
)
```

