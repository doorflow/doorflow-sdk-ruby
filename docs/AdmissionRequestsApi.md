# DoorFlow::AdmissionRequestsApi

All URIs are relative to *https://api.doorflow.com*

| Method | HTTP request | Description |
| ------ | ------------ | ----------- |
| [**get_admission_request**](AdmissionRequestsApi.md#get_admission_request) | **GET** /api/3/admission_requests/{id} | Get admission request status |


## get_admission_request

> <AdmissionRequest> get_admission_request(id)

Get admission request status

Returns the status of an admission request created via POST /api/3/channels/:id/admit or POST /api/3/channels/:id/admit_person. Use this to track whether the admission was successful, denied, or is still pending a response from the door controller. 

### Examples

```ruby
require 'time'
require 'doorflow-api'
# setup authorization
DoorFlow.configure do |config|
  # Configure OAuth2 access token for authorization: OAuth2
  config.access_token = 'YOUR ACCESS TOKEN'
end

api_instance = DoorFlow::AdmissionRequestsApi.new
id = 56 # Integer | Admission request ID (Event ID returned from admit/admit_person endpoints)

begin
  # Get admission request status
  result = api_instance.get_admission_request(id)
  p result
rescue DoorFlow::ApiError => e
  puts "Error when calling AdmissionRequestsApi->get_admission_request: #{e}"
end
```

#### Using the get_admission_request_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<AdmissionRequest>, Integer, Hash)> get_admission_request_with_http_info(id)

```ruby
begin
  # Get admission request status
  data, status_code, headers = api_instance.get_admission_request_with_http_info(id)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <AdmissionRequest>
rescue DoorFlow::ApiError => e
  puts "Error when calling AdmissionRequestsApi->get_admission_request_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **id** | **Integer** | Admission request ID (Event ID returned from admit/admit_person endpoints) |  |

### Return type

[**AdmissionRequest**](AdmissionRequest.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

