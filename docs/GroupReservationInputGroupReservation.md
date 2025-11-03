# DoorFlow::GroupReservationInputGroupReservation

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **person_id** | **Integer** | ID of the person to assign to groups (must belong to the same account) |  |
| **start_time** | **Time** | Start time of the group reservation |  |
| **end_time** | **Time** | End time of the group reservation (must be after start time and in the future) |  |
| **group_ids** | **Array&lt;Integer&gt;** | Array of group IDs to assign the person to (at least one required, all must belong to the account) |  |

## Example

```ruby
require 'doorflow-api'

instance = DoorFlow::GroupReservationInputGroupReservation.new(
  person_id: 12345,
  start_time: 2024-01-15T09:00Z,
  end_time: 2024-01-15T17:00Z,
  group_ids: [1,3,5]
)
```

