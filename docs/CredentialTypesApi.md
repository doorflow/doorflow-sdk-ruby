# DoorFlow::CredentialTypesApi

All URIs are relative to *https://api.doorflow.com*

| Method | HTTP request | Description |
| ------ | ------------ | ----------- |
| [**list_credential_types**](CredentialTypesApi.md#list_credential_types) | **GET** /api/3/credential_types | List credential types |


## list_credential_types

> <Array<CredentialType>> list_credential_types(opts)

List credential types

Returns a paginated list of credential types configured for the authenticated user's account. Credential types define the formats and types of credentials (cards, PINs, mobile access, etc.) that can be used. Each credential type is based on a global credential type and can be customized per account. 

### Examples

```ruby
require 'time'
require 'doorflow-api'
# setup authorization
DoorFlow.configure do |config|
  # Configure OAuth2 access token for authorization: OAuth2
  config.access_token = 'YOUR ACCESS TOKEN'
end

api_instance = DoorFlow::CredentialTypesApi.new
opts = {
  per_page: 56, # Integer | Number of results per page
  page: 56, # Integer | Page number for pagination
  skip_pagination: true # Boolean | Skip pagination and return all results
}

begin
  # List credential types
  result = api_instance.list_credential_types(opts)
  p result
rescue DoorFlow::ApiError => e
  puts "Error when calling CredentialTypesApi->list_credential_types: #{e}"
end
```

#### Using the list_credential_types_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<Array<CredentialType>>, Integer, Hash)> list_credential_types_with_http_info(opts)

```ruby
begin
  # List credential types
  data, status_code, headers = api_instance.list_credential_types_with_http_info(opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <Array<CredentialType>>
rescue DoorFlow::ApiError => e
  puts "Error when calling CredentialTypesApi->list_credential_types_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **per_page** | **Integer** | Number of results per page | [optional][default to 500] |
| **page** | **Integer** | Page number for pagination | [optional][default to 1] |
| **skip_pagination** | **Boolean** | Skip pagination and return all results | [optional] |

### Return type

[**Array&lt;CredentialType&gt;**](CredentialType.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

