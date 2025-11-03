# DoorFlow::EventsApi

All URIs are relative to *https://api.doorflow.com*

| Method | HTTP request | Description |
| ------ | ------------ | ----------- |
| [**get_event**](EventsApi.md#get_event) | **GET** /api/3/events/{id} | Get event details |
| [**list_events**](EventsApi.md#list_events) | **GET** /api/3/events | List events |


## get_event

> <Event> get_event(id, opts)

Get event details

Returns details for a specific event by ID. Supports webhook acknowledgment via callback/ack_token parameters.

### Examples

```ruby
require 'time'
require 'doorflow-api'
# setup authorization
DoorFlow.configure do |config|
  # Configure OAuth2 access token for authorization: OAuth2
  config.access_token = 'YOUR ACCESS TOKEN'
end

api_instance = DoorFlow::EventsApi.new
id = 56 # Integer | Event ID
opts = {
  callback: 'callback_example', # String | Webhook callback ID for acknowledgment
  ack_token: 'ack_token_example' # String | Webhook acknowledgment token
}

begin
  # Get event details
  result = api_instance.get_event(id, opts)
  p result
rescue DoorFlow::ApiError => e
  puts "Error when calling EventsApi->get_event: #{e}"
end
```

#### Using the get_event_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<Event>, Integer, Hash)> get_event_with_http_info(id, opts)

```ruby
begin
  # Get event details
  data, status_code, headers = api_instance.get_event_with_http_info(id, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <Event>
rescue DoorFlow::ApiError => e
  puts "Error when calling EventsApi->get_event_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **id** | **Integer** | Event ID |  |
| **callback** | **String** | Webhook callback ID for acknowledgment | [optional] |
| **ack_token** | **String** | Webhook acknowledgment token | [optional] |

### Return type

[**Event**](Event.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## list_events

> <Array<Event>> list_events(opts)

List events

Returns a paginated list of events (access control activity logs) for the authenticated user's account. By default, returns person access events (admits and rejects) from the last 90 days. Use `event_codes` parameter to filter by specific event types, or `level=debug` to include channel status events. 

### Examples

```ruby
require 'time'
require 'doorflow-api'
# setup authorization
DoorFlow.configure do |config|
  # Configure OAuth2 access token for authorization: OAuth2
  config.access_token = 'YOUR ACCESS TOKEN'
end

api_instance = DoorFlow::EventsApi.new
opts = {
  event_codes: [37], # Array<Integer> | Comma-separated list of event codes to filter by. If not specified, defaults to person access events (admits and rejects). Allowed event codes include: admit codes (10-18, 70), reject codes (20-29, 71-73), channel status codes (1-3), auto-unlock codes (40-42), tamper codes (90-91), door alarm codes (31-37), REX codes (30), sync codes (100-107), LDAP sync codes (220, 223-225). 
  first_name: 'first_name_example', # String | Filter by person's first name
  last_name: 'last_name_example', # String | Filter by person's last name
  channels: [37], # Array<Integer> | Filter by channel IDs (comma-separated)
  door_controllers: [37], # Array<Integer> | Filter by door controller IDs (alias for channels parameter)
  since: Time.parse('2013-10-20T19:20:30+01:00'), # Time | Return events created since this timestamp. Defaults to 90 days ago if not specified.
  level: 'debug', # String | Set to \"debug\" to include channel status events in addition to access events
  sort: 'ASC', # String | Sort order for results
  n: 56, # Integer | Number of results per page (max 1000)
  page: 56 # Integer | Page number for pagination
}

begin
  # List events
  result = api_instance.list_events(opts)
  p result
rescue DoorFlow::ApiError => e
  puts "Error when calling EventsApi->list_events: #{e}"
end
```

#### Using the list_events_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<Array<Event>>, Integer, Hash)> list_events_with_http_info(opts)

```ruby
begin
  # List events
  data, status_code, headers = api_instance.list_events_with_http_info(opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <Array<Event>>
rescue DoorFlow::ApiError => e
  puts "Error when calling EventsApi->list_events_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **event_codes** | [**Array&lt;Integer&gt;**](Integer.md) | Comma-separated list of event codes to filter by. If not specified, defaults to person access events (admits and rejects). Allowed event codes include: admit codes (10-18, 70), reject codes (20-29, 71-73), channel status codes (1-3), auto-unlock codes (40-42), tamper codes (90-91), door alarm codes (31-37), REX codes (30), sync codes (100-107), LDAP sync codes (220, 223-225).  | [optional] |
| **first_name** | **String** | Filter by person&#39;s first name | [optional] |
| **last_name** | **String** | Filter by person&#39;s last name | [optional] |
| **channels** | [**Array&lt;Integer&gt;**](Integer.md) | Filter by channel IDs (comma-separated) | [optional] |
| **door_controllers** | [**Array&lt;Integer&gt;**](Integer.md) | Filter by door controller IDs (alias for channels parameter) | [optional] |
| **since** | **Time** | Return events created since this timestamp. Defaults to 90 days ago if not specified. | [optional] |
| **level** | **String** | Set to \&quot;debug\&quot; to include channel status events in addition to access events | [optional] |
| **sort** | **String** | Sort order for results | [optional][default to &#39;DESC&#39;] |
| **n** | **Integer** | Number of results per page (max 1000) | [optional][default to 50] |
| **page** | **Integer** | Page number for pagination | [optional][default to 1] |

### Return type

[**Array&lt;Event&gt;**](Event.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

