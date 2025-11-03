# DoorFlow::CredentialInputPersonCredential

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **credential_type_id** | **Integer** | ID of the credential type (required) |  |
| **value** | **String** | Credential value (for card numbers, PINs, etc. Use \&quot;******\&quot; to auto-generate a random PIN) | [optional] |
| **person_id** | **Integer** | Person ID (typically derived from URL path parameter) | [optional] |

## Example

```ruby
require 'doorflow-api'

instance = DoorFlow::CredentialInputPersonCredential.new(
  credential_type_id: 5,
  value: 1234567890,
  person_id: null
)
```

