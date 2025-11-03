# DoorFlow::UnlockChannelRequest

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **relock_at** | **Time** | Time when door should automatically relock (optional) | [optional] |

## Example

```ruby
require 'doorflow-api'

instance = DoorFlow::UnlockChannelRequest.new(
  relock_at: 2024-01-15T17:00Z
)
```

