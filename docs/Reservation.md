# DoorFlow::Reservation

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **id** | **Integer** | Unique identifier for the reservation |  |
| **person_id** | **Integer** | ID of the person granted temporary access |  |
| **start_time** | **Time** | Start time of the reservation |  |
| **end_time** | **Time** | End time of the reservation (must be after start time and on the same day) |  |
| **channel_ids** | **Array&lt;Integer&gt;** | Array of channel (door controller) IDs the person has access to during this reservation |  |
| **created_at** | **Time** | Timestamp of creation |  |
| **updated_at** | **Time** | Timestamp of last update |  |

## Example

```ruby
require 'doorflow-api'

instance = DoorFlow::Reservation.new(
  id: 789,
  person_id: 12345,
  start_time: 2024-01-15T09:00Z,
  end_time: 2024-01-15T17:00Z,
  channel_ids: [1340,1341],
  created_at: null,
  updated_at: null
)
```

