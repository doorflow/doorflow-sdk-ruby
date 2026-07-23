# DoorFlow::CardDesignInput

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **name** | **String** | Name of the card design (required for creation) | [optional] |
| **notes** | **String** | Free-text notes about the card design | [optional] |
| **image_front_base64** | **String** | Base64-encoded image data for the front of the card (data URI format, e.g. data:image/png;base64,...) | [optional] |
| **image_back_base64** | **String** | Base64-encoded image data for the back of the card (data URI format, e.g. data:image/png;base64,...) | [optional] |

## Example

```ruby
require 'doorflow-api'

instance = DoorFlow::CardDesignInput.new(
  name: Standard Blue Card,
  notes: null,
  image_front_base64: null,
  image_back_base64: null
)
```

