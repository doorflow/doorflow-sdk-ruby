# DoorFlow::AutoUnlockChannelRequest

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **shift_id** | **Integer** | ID of shift for auto-unlock (null or omit to disable) | [optional] |

## Example

```ruby
require 'doorflow-api'

instance = DoorFlow::AutoUnlockChannelRequest.new(
  shift_id: 10
)
```

