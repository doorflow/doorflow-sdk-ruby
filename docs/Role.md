# DoorFlow::Role

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **id** | **Integer** | Unique identifier for the role |  |
| **name** | **String** | Name of the role (must be unique within the account) |  |
| **shift_id** | **Integer** | ID of the shift defining when this role grants access (null means 24/7 access) | [optional] |
| **notes** | **String** | Additional notes about this role | [optional] |
| **created_at** | **Time** | Timestamp of creation |  |
| **updated_at** | **Time** | Timestamp of last update |  |

## Example

```ruby
require 'doorflow-api'

instance = DoorFlow::Role.new(
  id: 42,
  name: Office Staff,
  shift_id: 10,
  notes: Access to main building during business hours,
  created_at: null,
  updated_at: null
)
```

