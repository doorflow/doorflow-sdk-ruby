# DoorFlow::CardDesign

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **id** | **Integer** | Unique identifier for the card design |  |
| **name** | **String** | Name of the card design |  |
| **notes** | **String** | Free-text notes about the card design | [optional] |
| **image_front** | [**CardDesignImageFront**](CardDesignImageFront.md) |  | [optional] |
| **image_back** | [**CardDesignImageBack**](CardDesignImageBack.md) |  | [optional] |
| **created_at** | **Time** | Timestamp of creation | [optional] |
| **updated_at** | **Time** | Timestamp of last update | [optional] |

## Example

```ruby
require 'doorflow-api'

instance = DoorFlow::CardDesign.new(
  id: 42,
  name: Standard Blue Card,
  notes: Used for full-time employees,
  image_front: null,
  image_back: null,
  created_at: null,
  updated_at: null
)
```

