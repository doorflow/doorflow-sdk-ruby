# DoorFlow::ElementSessionsApi

All URIs are relative to *https://api.doorflow.com*

| Method | HTTP request | Description |
| ------ | ------------ | ----------- |
| [**create_element_session**](ElementSessionsApi.md#create_element_session) | **POST** /api/3/element_sessions | Create an Elements widget session |


## create_element_session

> <ElementSession> create_element_session(element_session_input)

Create an Elements widget session

Mints a short-lived JWT session token authorising one Elements widget instance for one identified subject. The token is delivered to the widget shell via the host page or app, then forwarded to DoorFlow. Tokens expire after 15 minutes; long-lived widgets refresh by calling this endpoint again from the host backend.  The `member` block is the integrator's CRM-side identity for the person; DoorFlow find-or-creates a `Person` against `external_id` on the authenticated account. 

### Examples

```ruby
require 'time'
require 'doorflow-api'
# setup authorization
DoorFlow.configure do |config|
  # Configure OAuth2 access token for authorization: OAuth2
  config.access_token = 'YOUR ACCESS TOKEN'
end

api_instance = DoorFlow::ElementSessionsApi.new
element_session_input = DoorFlow::ElementSessionInput.new({widget_type: 'admin', member: DoorFlow::ElementSessionMember.new({external_id: 'u_42'})}) # ElementSessionInput | 

begin
  # Create an Elements widget session
  result = api_instance.create_element_session(element_session_input)
  p result
rescue DoorFlow::ApiError => e
  puts "Error when calling ElementSessionsApi->create_element_session: #{e}"
end
```

#### Using the create_element_session_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<ElementSession>, Integer, Hash)> create_element_session_with_http_info(element_session_input)

```ruby
begin
  # Create an Elements widget session
  data, status_code, headers = api_instance.create_element_session_with_http_info(element_session_input)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <ElementSession>
rescue DoorFlow::ApiError => e
  puts "Error when calling ElementSessionsApi->create_element_session_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **element_session_input** | [**ElementSessionInput**](ElementSessionInput.md) |  |  |

### Return type

[**ElementSession**](ElementSession.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json

