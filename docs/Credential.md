# DoorFlow::Credential

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **id** | **String** | Unique hashid identifier for the credential |  |
| **credential_type_id** | **Integer** | ID of the credential type |  |
| **label** | **String** | Human-readable label for the credential type |  |
| **person_id** | **Integer** | ID of the person this credential belongs to |  |
| **value** | **String** | Credential value (only present for value-assignable credential types like cards, PINs, etc. Not present for mobile credentials) | [optional] |
| **status** | **String** | Status for mobile credentials | [optional] |
| **url** | **String** | PassFlow credential URL (only for PassFlow credentials in invited state) | [optional] |
| **wallet_type** | **String** | Wallet type for PassFlow credentials that have been added to wallet | [optional] |

## Example

```ruby
require 'doorflow-api'

instance = DoorFlow::Credential.new(
  id: abc123xyz,
  credential_type_id: 5,
  label: Card Number,
  person_id: 12345,
  value: 1234567890,
  status: invited,
  url: null,
  wallet_type: null
)
```

