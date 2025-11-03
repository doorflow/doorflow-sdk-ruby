# DoorFlow::OauthApi

All URIs are relative to *https://api.doorflow.com*

| Method | HTTP request | Description |
| ------ | ------------ | ----------- |
| [**authorize_o_auth**](OauthApi.md#authorize_o_auth) | **GET** /oauth/authorize | Authorization endpoint |
| [**get_access_token**](OauthApi.md#get_access_token) | **POST** /oauth/token | Obtain access token |
| [**get_token_info**](OauthApi.md#get_token_info) | **GET** /oauth/token/info | Get token information |
| [**revoke_token**](OauthApi.md#revoke_token) | **POST** /oauth/revoke | Revoke access token or refresh token |


## authorize_o_auth

> authorize_o_auth(response_type, client_id, redirect_uri, scope, opts)

Authorization endpoint

Initiates the OAuth 2.0 authorization code flow. Direct users to this endpoint to request authorization.  **Authorization Code Flow Steps:** 1. Direct the user's browser to this endpoint with required parameters 2. User logs in (if not already authenticated) and authorizes your application 3. User is redirected to your `redirect_uri` with an authorization `code` parameter 4. Exchange the code for an access token at `/oauth/token`  **PKCE (Proof Key for Code Exchange):** For public clients (mobile/SPA applications), PKCE is recommended for security: 1. Generate a random `code_verifier` (43-128 characters) 2. Create `code_challenge` = BASE64URL(SHA256(code_verifier)) 3. Include `code_challenge` and `code_challenge_method=S256` in this request 4. Include `code_verifier` when exchanging the code at `/oauth/token`  **Important Notes:** - This is a browser-based flow - users will see a login/authorization screen - The `redirect_uri` must be pre-registered with your OAuth application - The authorization code expires after 10 minutes - Some applications may be configured to skip the authorization screen (auto-approve) 

### Examples

```ruby
require 'time'
require 'doorflow-api'

api_instance = DoorFlow::OauthApi.new
response_type = 'code' # String | OAuth response type (must be \"code\" for authorization code flow)
client_id = 'abc123xyz' # String | Your OAuth application's client ID
redirect_uri = 'https://example.com/callback' # String | URI to redirect to after authorization (must match registered redirect URI)
scope = 'account.person.readonly account.channel.readonly' # String | Space-separated list of requested scopes (see available scopes in security schemes section)
opts = {
  state: 'random_state_string_123', # String | Opaque value to maintain state between request and callback (recommended for CSRF protection)
  code_challenge: 'E9Melhoa2OwvFrEMTJguCHaoeK1t8URWbuGJSstw-cM', # String | PKCE code challenge (BASE64URL(SHA256(code_verifier)))
  code_challenge_method: 'S256' # String | PKCE code challenge method (must be S256)
}

begin
  # Authorization endpoint
  api_instance.authorize_o_auth(response_type, client_id, redirect_uri, scope, opts)
rescue DoorFlow::ApiError => e
  puts "Error when calling OauthApi->authorize_o_auth: #{e}"
end
```

#### Using the authorize_o_auth_with_http_info variant

This returns an Array which contains the response data (`nil` in this case), status code and headers.

> <Array(nil, Integer, Hash)> authorize_o_auth_with_http_info(response_type, client_id, redirect_uri, scope, opts)

```ruby
begin
  # Authorization endpoint
  data, status_code, headers = api_instance.authorize_o_auth_with_http_info(response_type, client_id, redirect_uri, scope, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => nil
rescue DoorFlow::ApiError => e
  puts "Error when calling OauthApi->authorize_o_auth_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **response_type** | **String** | OAuth response type (must be \&quot;code\&quot; for authorization code flow) |  |
| **client_id** | **String** | Your OAuth application&#39;s client ID |  |
| **redirect_uri** | **String** | URI to redirect to after authorization (must match registered redirect URI) |  |
| **scope** | **String** | Space-separated list of requested scopes (see available scopes in security schemes section) |  |
| **state** | **String** | Opaque value to maintain state between request and callback (recommended for CSRF protection) | [optional] |
| **code_challenge** | **String** | PKCE code challenge (BASE64URL(SHA256(code_verifier))) | [optional] |
| **code_challenge_method** | **String** | PKCE code challenge method (must be S256) | [optional] |

### Return type

nil (empty response body)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: text/html


## get_access_token

> <GetAccessToken200Response> get_access_token(grant_type, opts)

Obtain access token

Exchange authorization code for an access token, or refresh an existing token.  **Authorization Code Flow:** 1. Direct users to `/oauth/authorize` with your client_id, redirect_uri, and requested scopes 2. User authorizes your application 3. You receive an authorization code at your redirect_uri 4. Exchange the code for an access token using this endpoint with `grant_type=authorization_code`  **Refreshing Tokens:** - Use `grant_type=refresh_token` with a valid refresh_token to obtain a new access token - Access tokens expire after 1 hour - Refresh tokens are long-lived and should be stored securely 

### Examples

```ruby
require 'time'
require 'doorflow-api'

api_instance = DoorFlow::OauthApi.new
grant_type = 'authorization_code' # String | OAuth grant type (use \\\"authorization_code\\\" to exchange an authorization code, or \\\"refresh_token\\\" to refresh an access token)
opts = {
  client_id: 'client_id_example', # String | OAuth client ID (required for all grant types)
  client_secret: 'client_secret_example', # String | OAuth client secret (required for confidential clients)
  code: 'code_example', # String | Authorization code (required when grant_type=authorization_code)
  redirect_uri: 'redirect_uri_example', # String | Redirect URI (required when grant_type=authorization_code, must match the one used in authorization request)
  code_verifier: 'code_verifier_example', # String | PKCE code verifier (required if PKCE was used in authorization request)
  refresh_token: 'refresh_token_example', # String | Refresh token (required when grant_type=refresh_token)
  scope: 'scope_example' # String | Space-separated list of requested scopes (optional, defaults to application's configured scopes)
}

begin
  # Obtain access token
  result = api_instance.get_access_token(grant_type, opts)
  p result
rescue DoorFlow::ApiError => e
  puts "Error when calling OauthApi->get_access_token: #{e}"
end
```

#### Using the get_access_token_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<GetAccessToken200Response>, Integer, Hash)> get_access_token_with_http_info(grant_type, opts)

```ruby
begin
  # Obtain access token
  data, status_code, headers = api_instance.get_access_token_with_http_info(grant_type, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <GetAccessToken200Response>
rescue DoorFlow::ApiError => e
  puts "Error when calling OauthApi->get_access_token_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **grant_type** | **String** | OAuth grant type (use \\\&quot;authorization_code\\\&quot; to exchange an authorization code, or \\\&quot;refresh_token\\\&quot; to refresh an access token) |  |
| **client_id** | **String** | OAuth client ID (required for all grant types) | [optional] |
| **client_secret** | **String** | OAuth client secret (required for confidential clients) | [optional] |
| **code** | **String** | Authorization code (required when grant_type&#x3D;authorization_code) | [optional] |
| **redirect_uri** | **String** | Redirect URI (required when grant_type&#x3D;authorization_code, must match the one used in authorization request) | [optional] |
| **code_verifier** | **String** | PKCE code verifier (required if PKCE was used in authorization request) | [optional] |
| **refresh_token** | **String** | Refresh token (required when grant_type&#x3D;refresh_token) | [optional] |
| **scope** | **String** | Space-separated list of requested scopes (optional, defaults to application&#39;s configured scopes) | [optional] |

### Return type

[**GetAccessToken200Response**](GetAccessToken200Response.md)

### Authorization

No authorization required

### HTTP request headers

- **Content-Type**: application/x-www-form-urlencoded
- **Accept**: application/json


## get_token_info

> <GetTokenInfo200Response> get_token_info

Get token information

Returns information about the current access token being used for authentication.  This endpoint provides metadata about the access token including the resource owner, account, scopes, and expiration.  **Authentication:** Requires a valid OAuth2 access token in the Authorization header. 

### Examples

```ruby
require 'time'
require 'doorflow-api'
# setup authorization
DoorFlow.configure do |config|
  # Configure OAuth2 access token for authorization: OAuth2
  config.access_token = 'YOUR ACCESS TOKEN'
end

api_instance = DoorFlow::OauthApi.new

begin
  # Get token information
  result = api_instance.get_token_info
  p result
rescue DoorFlow::ApiError => e
  puts "Error when calling OauthApi->get_token_info: #{e}"
end
```

#### Using the get_token_info_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<GetTokenInfo200Response>, Integer, Hash)> get_token_info_with_http_info

```ruby
begin
  # Get token information
  data, status_code, headers = api_instance.get_token_info_with_http_info
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <GetTokenInfo200Response>
rescue DoorFlow::ApiError => e
  puts "Error when calling OauthApi->get_token_info_with_http_info: #{e}"
end
```

### Parameters

This endpoint does not need any parameter.

### Return type

[**GetTokenInfo200Response**](GetTokenInfo200Response.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## revoke_token

> Object revoke_token(authorization, token, opts)

Revoke access token or refresh token

Revokes an access token or refresh token, immediately invalidating it and blocking associated tokens from making further requests.  **When to revoke:** - User disconnects their DoorFlow account from your integration - User logs out - Security breach - revoke compromised tokens - Application uninstall  **Important:** - **We recommend revoking the refresh_token** - this will invalidate all associated access tokens - Returns HTTP 200 even if the token was already invalid (prevents token scanning attacks) - Client authentication is required via HTTP Basic Auth header  **Authentication:** You must authenticate using HTTP Basic Authentication with your client credentials: 1. Combine your client_id and client_secret as: `{client_id}:{client_secret}` 2. Encode using URL-safe Base64 3. Include in Authorization header: `Authorization: Basic {encoded_credentials}` 

### Examples

```ruby
require 'time'
require 'doorflow-api'
# setup authorization
DoorFlow.configure do |config|
  # Configure HTTP basic authorization: basicAuth
  config.username = 'YOUR USERNAME'
  config.password = 'YOUR PASSWORD'
end

api_instance = DoorFlow::OauthApi.new
authorization = 'Basic Y2xpZW50X2lkOmNsaWVudF9zZWNyZXQ=' # String | HTTP Basic Authentication using client_id:client_secret encoded with URL-safe Base64
token = 'token_example' # String | The access token or refresh token to revoke (we recommend using refresh_token)
opts = {
  token_type_hint: 'access_token' # String | Optional hint about the type of token being revoked. We recommend using 'refresh_token' for all revocations as it invalidates all associated tokens. Invalid token type hint values are ignored and do not affect the revocation response. 
}

begin
  # Revoke access token or refresh token
  result = api_instance.revoke_token(authorization, token, opts)
  p result
rescue DoorFlow::ApiError => e
  puts "Error when calling OauthApi->revoke_token: #{e}"
end
```

#### Using the revoke_token_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(Object, Integer, Hash)> revoke_token_with_http_info(authorization, token, opts)

```ruby
begin
  # Revoke access token or refresh token
  data, status_code, headers = api_instance.revoke_token_with_http_info(authorization, token, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => Object
rescue DoorFlow::ApiError => e
  puts "Error when calling OauthApi->revoke_token_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **authorization** | **String** | HTTP Basic Authentication using client_id:client_secret encoded with URL-safe Base64 |  |
| **token** | **String** | The access token or refresh token to revoke (we recommend using refresh_token) |  |
| **token_type_hint** | **String** | Optional hint about the type of token being revoked. We recommend using &#39;refresh_token&#39; for all revocations as it invalidates all associated tokens. Invalid token type hint values are ignored and do not affect the revocation response.  | [optional] |

### Return type

**Object**

### Authorization

[basicAuth](../README.md#basicAuth)

### HTTP request headers

- **Content-Type**: application/x-www-form-urlencoded
- **Accept**: application/json

