# DoorFlow::Event

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **id** | **Integer** | Unique identifier for the event |  |
| **event_id** | **Integer** | Same as id (legacy field for backward compatibility) | [optional] |
| **event_code** | **Integer** | Numeric code identifying the event type. Common codes: - 10-18: Admit events (card, PIN, manual, REX, AUX, application, unlocked, Apple, Google) - 20-29: Reject events (card, out of hours, lockdown, tamper, PIN, timeout, invalid type, unauthorized, pass-back, offline) - 30: REX pressed - 31-37: Door state/alarm events - 40-42: Auto-unlock shift events - 50-63: Remote control events - 70-73: Multi-factor authentication events - 90-91: Tamper events - 100-107: Channel sync events  |  |
| **event_label** | **String** | Human-readable description of the event |  |
| **door_controller_id** | **Integer** | ID of the door controller (channel) where the event occurred | [optional] |
| **door_controller_name** | **String** | Name of the door controller (channel) | [optional] |
| **channel_id** | **Integer** | Alias for door_controller_id | [optional] |
| **channel_name** | **String** | Alias for door_controller_name | [optional] |
| **person_id** | **Integer** | ID of the person associated with this event (for access events) | [optional] |
| **person_name** | **String** | Name of the person associated with this event | [optional] |
| **credentials_number** | **String** | Credential number used (card number, PIN, etc.) | [optional] |
| **created_at** | **Time** | Timestamp when the event occurred |  |
| **updated_at** | **Time** | Timestamp when the event record was last updated |  |

## Example

```ruby
require 'doorflow-api'

instance = DoorFlow::Event.new(
  id: 123456789,
  event_id: 123456789,
  event_code: 10,
  event_label: John Doe admitted using card,
  door_controller_id: 1340,
  door_controller_name: Front Door,
  channel_id: 1340,
  channel_name: Front Door,
  person_id: 12345,
  person_name: John Doe,
  credentials_number: 1234567890,
  created_at: 2024-01-15T14:30Z,
  updated_at: 2024-01-15T14:30Z
)
```

