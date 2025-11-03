# DoorFlow::GetTokenInfo200Response

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **resource_owner_id** | **Integer** | ID of the user (resource owner) who authorized this token |  |
| **account_id** | **String** | Hashid of the account associated with the resource owner | [optional] |
| **scope** | **Array&lt;String&gt;** | Array of OAuth scopes granted to this token |  |
| **expires_in** | **Integer** | Number of seconds until the token expires |  |
| **application** | [**GetTokenInfo200ResponseApplication**](GetTokenInfo200ResponseApplication.md) |  | [optional] |
| **created_at** | **Integer** | Unix timestamp when the token was created |  |

## Example

```ruby
require 'doorflow-api'

instance = DoorFlow::GetTokenInfo200Response.new(
  resource_owner_id: 12345,
  account_id: abc123xyz,
  scope: [&quot;account.person.readonly&quot;,&quot;account.channel.readonly&quot;],
  expires_in: 7200,
  application: null,
  created_at: 1704067200
)
```

