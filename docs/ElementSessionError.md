# DoorFlow::ElementSessionError

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **error** | **String** | Typed error code so SDK callers can branch without parsing the human-readable message.  |  |
| **message** | **String** | Human-readable description of the error. | [optional] |

## Example

```ruby
require 'doorflow-api'

instance = DoorFlow::ElementSessionError.new(
  error: null,
  message: null
)
```

