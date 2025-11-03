# DoorFlow::ListEvents400Response

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **error** | **String** |  | [optional] |
| **error_description** | **String** |  | [optional] |

## Example

```ruby
require 'doorflow-api'

instance = DoorFlow::ListEvents400Response.new(
  error: bad_request,
  error_description: The following event codes are not valid for this method: 999
)
```

