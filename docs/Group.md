# DoorFlow::Group

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **id** | **Integer** | Unique identifier for the group |  |
| **name** | **String** | Name of the group (must be present) |  |
| **notes** | **String** | Additional notes about this group | [optional] |
| **global_across_sites** | **Boolean** | Whether this group applies across all sites in multi-site deployments |  |
| **created_at** | **Time** | Timestamp of creation |  |
| **updated_at** | **Time** | Timestamp of last update |  |

## Example

```ruby
require 'doorflow-api'

instance = DoorFlow::Group.new(
  id: 15,
  name: Marketing Team,
  notes: Access to marketing floor and conference rooms,
  global_across_sites: false,
  created_at: null,
  updated_at: null
)
```

