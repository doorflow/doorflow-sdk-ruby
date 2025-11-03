# DoorFlow::AccountPassport

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **remote_unlock_enabled** | **Boolean** | Whether passport remote unlock is enabled |  |
| **hid_mobile_access** | **Boolean** | Whether HID mobile access is configured |  |

## Example

```ruby
require 'doorflow-api'

instance = DoorFlow::AccountPassport.new(
  remote_unlock_enabled: null,
  hid_mobile_access: null
)
```

