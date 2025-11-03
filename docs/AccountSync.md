# DoorFlow::AccountSync

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **status** | **String** | Current sync status |  |
| **last_sync** | **Time** | Timestamp of last sync initiation |  |
| **description** | **String** | Detailed description of sync status (e.g., \&quot;2 of 5 failed\&quot;) | [optional] |

## Example

```ruby
require 'doorflow-api'

instance = DoorFlow::AccountSync.new(
  status: null,
  last_sync: null,
  description: null
)
```

