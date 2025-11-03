# DoorFlow::AccountsApi

All URIs are relative to *https://api.doorflow.com*

| Method | HTTP request | Description |
| ------ | ------------ | ----------- |
| [**get_account**](AccountsApi.md#get_account) | **GET** /api/3/account | Get current account details |


## get_account

> <Account> get_account

Get current account details

Returns the account information for the authenticated user

### Examples

```ruby
require 'time'
require 'doorflow-api'
# setup authorization
DoorFlow.configure do |config|
  # Configure OAuth2 access token for authorization: OAuth2
  config.access_token = 'YOUR ACCESS TOKEN'
end

api_instance = DoorFlow::AccountsApi.new

begin
  # Get current account details
  result = api_instance.get_account
  p result
rescue DoorFlow::ApiError => e
  puts "Error when calling AccountsApi->get_account: #{e}"
end
```

#### Using the get_account_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<Account>, Integer, Hash)> get_account_with_http_info

```ruby
begin
  # Get current account details
  data, status_code, headers = api_instance.get_account_with_http_info
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <Account>
rescue DoorFlow::ApiError => e
  puts "Error when calling AccountsApi->get_account_with_http_info: #{e}"
end
```

### Parameters

This endpoint does not need any parameter.

### Return type

[**Account**](Account.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

