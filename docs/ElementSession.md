# DoorFlow::ElementSession

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **token** | **String** | Short-lived JWT to forward to the widget shell. |  |
| **expires_in** | **Integer** | Seconds until the token expires. |  |

## Example

```ruby
require 'doorflow-api'

instance = DoorFlow::ElementSession.new(
  token: eyJhbGciOiJIUzI1NiJ9...,
  expires_in: 900
)
```

