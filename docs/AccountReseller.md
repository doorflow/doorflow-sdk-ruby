# DoorFlow::AccountReseller

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **id** | **Integer** | Reseller ID | [optional] |
| **name** | **String** | Reseller name | [optional] |
| **support_contact** | **String** | Support contact name | [optional] |
| **support_email** | **String** | Support email address | [optional] |
| **support_telephone** | **String** | Support telephone number | [optional] |

## Example

```ruby
require 'doorflow-api'

instance = DoorFlow::AccountReseller.new(
  id: null,
  name: null,
  support_contact: null,
  support_email: null,
  support_telephone: null
)
```

