# DoorFlow::AdmitChannel202Response

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **admission_request_id** | **Integer** | ID of the admission request (Event ID) for status tracking | [optional] |
| **status** | **String** | Initial status of the admission request | [optional] |

## Example

```ruby
require 'doorflow-api'

instance = DoorFlow::AdmitChannel202Response.new(
  admission_request_id: 123456789,
  status: pending
)
```

