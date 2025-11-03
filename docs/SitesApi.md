# DoorFlow::SitesApi

All URIs are relative to *https://api.doorflow.com*

| Method | HTTP request | Description |
| ------ | ------------ | ----------- |
| [**list_sites**](SitesApi.md#list_sites) | **GET** /api/3/sites | List sites |


## list_sites

> <Array<Site>> list_sites(opts)

List sites

Returns a paginated list of sites (physical locations) accessible to the authenticated user. Sites are used to organize channels (door controllers) by physical location and can have their own time zones and IP address ranges. 

### Examples

```ruby
require 'time'
require 'doorflow-api'
# setup authorization
DoorFlow.configure do |config|
  # Configure OAuth2 access token for authorization: OAuth2
  config.access_token = 'YOUR ACCESS TOKEN'
end

api_instance = DoorFlow::SitesApi.new
opts = {
  per_page: 56, # Integer | Number of results per page
  page: 56, # Integer | Page number for pagination
  skip_pagination: true # Boolean | Skip pagination and return all results
}

begin
  # List sites
  result = api_instance.list_sites(opts)
  p result
rescue DoorFlow::ApiError => e
  puts "Error when calling SitesApi->list_sites: #{e}"
end
```

#### Using the list_sites_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<Array<Site>>, Integer, Hash)> list_sites_with_http_info(opts)

```ruby
begin
  # List sites
  data, status_code, headers = api_instance.list_sites_with_http_info(opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <Array<Site>>
rescue DoorFlow::ApiError => e
  puts "Error when calling SitesApi->list_sites_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **per_page** | **Integer** | Number of results per page | [optional][default to 500] |
| **page** | **Integer** | Page number for pagination | [optional][default to 1] |
| **skip_pagination** | **Boolean** | Skip pagination and return all results | [optional] |

### Return type

[**Array&lt;Site&gt;**](Site.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

