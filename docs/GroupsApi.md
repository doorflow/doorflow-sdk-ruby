# DoorFlow::GroupsApi

All URIs are relative to *https://api.doorflow.com*

| Method | HTTP request | Description |
| ------ | ------------ | ----------- |
| [**list_groups**](GroupsApi.md#list_groups) | **GET** /api/3/groups | List groups |


## list_groups

> <Array<Group>> list_groups

List groups

Returns a list of all groups accessible to the authenticated user, ordered by name. Groups are collections of people that can be assigned to roles for access control. Groups can be static (manually assigned) or dynamic (based on LDAP/directory queries). This endpoint does not support pagination. 

### Examples

```ruby
require 'time'
require 'doorflow-api'
# setup authorization
DoorFlow.configure do |config|
  # Configure OAuth2 access token for authorization: OAuth2
  config.access_token = 'YOUR ACCESS TOKEN'
end

api_instance = DoorFlow::GroupsApi.new

begin
  # List groups
  result = api_instance.list_groups
  p result
rescue DoorFlow::ApiError => e
  puts "Error when calling GroupsApi->list_groups: #{e}"
end
```

#### Using the list_groups_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<Array<Group>>, Integer, Hash)> list_groups_with_http_info

```ruby
begin
  # List groups
  data, status_code, headers = api_instance.list_groups_with_http_info
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <Array<Group>>
rescue DoorFlow::ApiError => e
  puts "Error when calling GroupsApi->list_groups_with_http_info: #{e}"
end
```

### Parameters

This endpoint does not need any parameter.

### Return type

[**Array&lt;Group&gt;**](Group.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

