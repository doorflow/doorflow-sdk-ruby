# DoorFlow::CredentialType

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **id** | **Integer** | Unique identifier for the credential type |  |
| **label** | **String** | Human-readable label for the credential type (must be unique within account) |  |
| **slug** | **String** | URL-friendly identifier used in API requests (must be unique within account, auto-parameterized) |  |
| **code** | **Integer** | Numeric code from the associated global credential type |  |

## Example

```ruby
require 'doorflow-api'

instance = DoorFlow::CredentialType.new(
  id: 5,
  label: Employee Card,
  slug: employee_card,
  code: 100
)
```

