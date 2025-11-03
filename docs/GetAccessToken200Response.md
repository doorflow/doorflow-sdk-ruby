# DoorFlow::GetAccessToken200Response

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **access_token** | **String** | Bearer token to use for API authentication |  |
| **token_type** | **String** | Token type (always \&quot;Bearer\&quot;) |  |
| **expires_in** | **Integer** | Number of seconds until the access token expires (3600 &#x3D; 1 hour) |  |
| **refresh_token** | **String** | Refresh token to obtain a new access token (only included on initial token grant) | [optional] |
| **scope** | **String** | Space-separated list of granted scopes | [optional] |
| **created_at** | **Integer** | Unix timestamp when the token was created |  |

## Example

```ruby
require 'doorflow-api'

instance = DoorFlow::GetAccessToken200Response.new(
  access_token: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...,
  token_type: Bearer,
  expires_in: 3600,
  refresh_token: refresh_token_here,
  scope: account.person.readonly account.channel.readonly,
  created_at: 1704067200
)
```

