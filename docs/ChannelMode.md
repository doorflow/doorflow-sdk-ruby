# DoorFlow::ChannelMode

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **description** | **String** | Current mode |  |
| **relock_at** | **Time** | Time when door will automatically relock (if in unlock mode) | [optional] |
| **change_stamp** | **Time** | Timestamp when mode was last changed | [optional] |

## Example

```ruby
require 'doorflow-api'

instance = DoorFlow::ChannelMode.new(
  description: null,
  relock_at: null,
  change_stamp: null
)
```

