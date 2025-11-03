# DoorFlow::AutoUnlockChannel400Response

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **success** | **Boolean** |  | [optional] |
| **message** | **String** |  | [optional] |

## Example

```ruby
require 'doorflow-api'

instance = DoorFlow::AutoUnlockChannel400Response.new(
  success: false,
  message: No shift found for shift_id - 999
)
```

