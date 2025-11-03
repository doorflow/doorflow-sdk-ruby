# DoorFlow::GroupReservation

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **id** | **Integer** | Unique identifier for the group reservation |  |
| **person_id** | **Integer** | ID of the person assigned to the groups |  |
| **start_time** | **Time** | Start time of the group reservation |  |
| **end_time** | **Time** | End time of the group reservation (must be after start time and in the future) |  |
| **state** | **String** | Current state of the reservation (pending &#x3D; not started, active &#x3D; in progress, deactivated &#x3D; cancelled or completed) |  |
| **group_ids** | **Array&lt;Integer&gt;** | Array of group IDs the person is assigned to during this reservation |  |
| **created_at** | **Time** | Timestamp of creation |  |
| **updated_at** | **Time** | Timestamp of last update |  |

## Example

```ruby
require 'doorflow-api'

instance = DoorFlow::GroupReservation.new(
  id: 456,
  person_id: 12345,
  start_time: 2024-01-15T09:00Z,
  end_time: 2024-01-15T17:00Z,
  state: active,
  group_ids: [1,3,5],
  created_at: null,
  updated_at: null
)
```

