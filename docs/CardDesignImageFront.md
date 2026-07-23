# DoorFlow::CardDesignImageFront

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **original** | **String** | Original uploaded image URL | [optional] |
| **medium** | **String** | Medium size (600x378) image URL | [optional] |
| **small** | **String** | Small size (300x189) image URL | [optional] |
| **thumb** | **String** | Thumbnail size (150x94) image URL | [optional] |

## Example

```ruby
require 'doorflow-api'

instance = DoorFlow::CardDesignImageFront.new(
  original: null,
  medium: null,
  small: null,
  thumb: null
)
```

