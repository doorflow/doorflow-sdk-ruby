# DoorFlow::CardTemplateTypeInputCardTemplateType

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **code** | **String** | Unique code (required for creation) | [optional] |
| **name** | **String** |  | [optional] |
| **page_size** | **String** |  | [optional] |
| **width_mm** | **Float** |  | [optional] |
| **height_mm** | **Float** |  | [optional] |
| **orientation_default** | **String** |  | [optional] |
| **non_printable_zones** | [**Array&lt;CardTemplateTypeInputCardTemplateTypeNonPrintableZonesInner&gt;**](CardTemplateTypeInputCardTemplateTypeNonPrintableZonesInner.md) | Non-printable zones. Replaces the entire array on update | [optional] |

## Example

```ruby
require 'doorflow-api'

instance = DoorFlow::CardTemplateTypeInputCardTemplateType.new(
  code: null,
  name: null,
  page_size: null,
  width_mm: null,
  height_mm: null,
  orientation_default: null,
  non_printable_zones: null
)
```

