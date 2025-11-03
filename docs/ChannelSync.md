# DoorFlow::ChannelSync

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **status** | **String** | Current sync status |  |
| **last_sync_completed_at** | **Time** | Timestamp of last successful sync completion |  |

## Example

```ruby
require 'doorflow-api'

instance = DoorFlow::ChannelSync.new(
  status: null,
  last_sync_completed_at: null
)
```

