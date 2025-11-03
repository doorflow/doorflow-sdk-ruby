# DoorFlow::ReservationInput

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **person_id** | **Integer** | ID of the person to grant temporary access (must belong to the same account) |  |
| **start_time** | **Time** | Start time of the reservation |  |
| **end_time** | **Time** | End time of the reservation (must be after start time and on the same day in account time zone) |  |
| **channel_ids** | **Array&lt;Integer&gt;** | Array of channel IDs to grant access to (at least one required, all must be accessible to the creator) | [optional] |
| **door_controller_ids** | **Array&lt;Integer&gt;** | Alias for channel_ids | [optional] |

## Example

```ruby
require 'doorflow-api'

instance = DoorFlow::ReservationInput.new(
  person_id: 12345,
  start_time: 2024-01-15T09:00Z,
  end_time: 2024-01-15T17:00Z,
  channel_ids: [1340,1341],
  door_controller_ids: [1340,1341]
)
```

