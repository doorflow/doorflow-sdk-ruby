# DoorFlow::CreateCredential422ResponseErrors

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **value** | **Array&lt;String&gt;** | Validation errors for the credential value | [optional] |
| **credential_type_id** | **Array&lt;String&gt;** | Validation errors for the credential type | [optional] |
| **limit_reached** | **String** | License limit error message | [optional] |

## Example

```ruby
require 'doorflow-api'

instance = DoorFlow::CreateCredential422ResponseErrors.new(
  value: [&quot;value is already in use on your account&quot;,&quot;must be between 4 and 7 digits in length&quot;],
  credential_type_id: [&quot;Not found for this account&quot;],
  limit_reached: You have reached your HID Mobile licence limit. Please contact DoorFlow Support.
)
```

