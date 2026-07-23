# DoorFlow::SyncApi

All URIs are relative to *https://api.doorflow.com*

| Method | HTTP request | Description |
| ------ | ------------ | ----------- |
| [**initiate_sync**](SyncApi.md#initiate_sync) | **POST** /api/3/sync | Initiate sync |


## initiate_sync

> <DeleteCardDesign200Response> initiate_sync

Initiate sync

Triggers a synchronization process to push pending changes to all door controllers. This endpoint initiates the sync if there are unsynced changes in the account. The sync process is rate-limited to prevent excessive sync requests. 

### Examples

```ruby
require 'time'
require 'doorflow-api'
# setup authorization
DoorFlow.configure do |config|
  # Configure OAuth2 access token for authorization: OAuth2
  config.access_token = 'YOUR ACCESS TOKEN'
end

api_instance = DoorFlow::SyncApi.new

begin
  # Initiate sync
  result = api_instance.initiate_sync
  p result
rescue DoorFlow::ApiError => e
  puts "Error when calling SyncApi->initiate_sync: #{e}"
end
```

#### Using the initiate_sync_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<DeleteCardDesign200Response>, Integer, Hash)> initiate_sync_with_http_info

```ruby
begin
  # Initiate sync
  data, status_code, headers = api_instance.initiate_sync_with_http_info
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <DeleteCardDesign200Response>
rescue DoorFlow::ApiError => e
  puts "Error when calling SyncApi->initiate_sync_with_http_info: #{e}"
end
```

### Parameters

This endpoint does not need any parameter.

### Return type

[**DeleteCardDesign200Response**](DeleteCardDesign200Response.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

