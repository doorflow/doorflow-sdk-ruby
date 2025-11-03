# DoorFlow::RolesApi

All URIs are relative to *https://api.doorflow.com*

| Method | HTTP request | Description |
| ------ | ------------ | ----------- |
| [**list_roles**](RolesApi.md#list_roles) | **GET** /api/3/roles | List roles |


## list_roles

> <Array<Role>> list_roles

List roles

Returns a list of all roles accessible to the authenticated user, ordered by name. Roles define which channels (door controllers) people or groups have access to, optionally within specific time shifts. This endpoint does not support pagination. 

### Examples

```ruby
require 'time'
require 'doorflow-api'
# setup authorization
DoorFlow.configure do |config|
  # Configure OAuth2 access token for authorization: OAuth2
  config.access_token = 'YOUR ACCESS TOKEN'
end

api_instance = DoorFlow::RolesApi.new

begin
  # List roles
  result = api_instance.list_roles
  p result
rescue DoorFlow::ApiError => e
  puts "Error when calling RolesApi->list_roles: #{e}"
end
```

#### Using the list_roles_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<Array<Role>>, Integer, Hash)> list_roles_with_http_info

```ruby
begin
  # List roles
  data, status_code, headers = api_instance.list_roles_with_http_info
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <Array<Role>>
rescue DoorFlow::ApiError => e
  puts "Error when calling RolesApi->list_roles_with_http_info: #{e}"
end
```

### Parameters

This endpoint does not need any parameter.

### Return type

[**Array&lt;Role&gt;**](Role.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

