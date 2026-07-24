# DoorFlow::CardTemplateTypeNonPrintableZonesInner

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **label** | **String** | Zone identifier | [optional] |
| **x_mm** | **Float** | X position from top-left in millimetres | [optional] |
| **y_mm** | **Float** | Y position from top-left in millimetres | [optional] |
| **width_mm** | **Float** | Zone width in millimetres | [optional] |
| **height_mm** | **Float** | Zone height in millimetres | [optional] |

## Example

```ruby
require 'doorflow-api'

instance = DoorFlow::CardTemplateTypeNonPrintableZonesInner.new(
  label: signature_stripe,
  x_mm: null,
  y_mm: null,
  width_mm: null,
  height_mm: null
)
```

