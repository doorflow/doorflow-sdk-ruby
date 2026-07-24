# DoorFlow::CardTemplateType

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **code** | **String** | Unique identifier for this type |  |
| **name** | **String** | Display name |  |
| **page_size** | **String** | Physical page size category | [optional] |
| **width_mm** | **Float** | Physical width in millimetres | [optional] |
| **height_mm** | **Float** | Physical height in millimetres | [optional] |
| **orientation_default** | **String** | Default orientation: P &#x3D; Portrait, L &#x3D; Landscape | [optional] |
| **preview_image_url** | **String** | URL to a preview image, or null if not set | [optional] |
| **non_printable_zones** | [**Array&lt;CardTemplateTypeNonPrintableZonesInner&gt;**](CardTemplateTypeNonPrintableZonesInner.md) | Non-printable zone definitions | [optional] |
| **created_at** | **Time** | When the record was created | [optional] |
| **updated_at** | **Time** | When the record was last updated | [optional] |

## Example

```ruby
require 'doorflow-api'

instance = DoorFlow::CardTemplateType.new(
  code: ISO_CARD,
  name: Standard ISO Card,
  page_size: ISO_CARD,
  width_mm: 85.6,
  height_mm: 54.0,
  orientation_default: L,
  preview_image_url: null,
  non_printable_zones: null,
  created_at: null,
  updated_at: null
)
```

