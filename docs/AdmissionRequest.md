# DoorFlow::AdmissionRequest

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **id** | **Integer** | Unique identifier for the admission request (Event ID) |  |
| **status** | **String** | Current status of the admission request: - pending: Waiting for door controller response - admitted: Person successfully admitted (event codes 15, 16, 50) - denied: Access denied (event code 51) - offline: Door controller offline (event code 52) - timeout: No response received within 2 minutes  |  |
| **channel_id** | **Integer** | ID of the channel (door controller) |  |
| **person_id** | **Integer** | ID of the person (null for general admit requests) | [optional] |
| **requested_at** | **Time** | Timestamp when the admission was requested |  |
| **completed_at** | **Time** | Timestamp when the admission completed (null if still pending) | [optional] |
| **door_controller** | [**AdmissionRequestDoorController**](AdmissionRequestDoorController.md) |  |  |
| **person** | [**AdmissionRequestPerson**](AdmissionRequestPerson.md) |  | [optional] |

## Example

```ruby
require 'doorflow-api'

instance = DoorFlow::AdmissionRequest.new(
  id: 123456789,
  status: admitted,
  channel_id: 1340,
  person_id: 12345,
  requested_at: 2024-01-15T14:30Z,
  completed_at: 2024-01-15T14:30:02.500Z,
  door_controller: null,
  person: null
)
```

