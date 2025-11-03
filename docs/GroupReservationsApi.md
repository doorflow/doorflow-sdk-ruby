# DoorFlow::GroupReservationsApi

All URIs are relative to *https://api.doorflow.com*

| Method | HTTP request | Description |
| ------ | ------------ | ----------- |
| [**create_group_reservation**](GroupReservationsApi.md#create_group_reservation) | **POST** /api/3/group_reservations | Create group reservation |
| [**delete_group_reservation**](GroupReservationsApi.md#delete_group_reservation) | **DELETE** /api/3/group_reservations/{id} | Delete group reservation |
| [**list_group_reservations**](GroupReservationsApi.md#list_group_reservations) | **GET** /api/3/group_reservations | List group reservations |


## create_group_reservation

> <GroupReservation> create_group_reservation(group_reservation_input)

Create group reservation

Creates a new group reservation to temporarily assign a person to one or more groups. The person will be automatically added to the specified groups during the reservation period. 

### Examples

```ruby
require 'time'
require 'doorflow-api'
# setup authorization
DoorFlow.configure do |config|
  # Configure OAuth2 access token for authorization: OAuth2
  config.access_token = 'YOUR ACCESS TOKEN'
end

api_instance = DoorFlow::GroupReservationsApi.new
group_reservation_input = DoorFlow::GroupReservationInput.new({group_reservation: DoorFlow::GroupReservationInputGroupReservation.new({person_id: 12345, start_time: Time.parse('2024-01-15T09:00Z'), end_time: Time.parse('2024-01-15T17:00Z'), group_ids: [1, 3, 5]})}) # GroupReservationInput | 

begin
  # Create group reservation
  result = api_instance.create_group_reservation(group_reservation_input)
  p result
rescue DoorFlow::ApiError => e
  puts "Error when calling GroupReservationsApi->create_group_reservation: #{e}"
end
```

#### Using the create_group_reservation_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<GroupReservation>, Integer, Hash)> create_group_reservation_with_http_info(group_reservation_input)

```ruby
begin
  # Create group reservation
  data, status_code, headers = api_instance.create_group_reservation_with_http_info(group_reservation_input)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <GroupReservation>
rescue DoorFlow::ApiError => e
  puts "Error when calling GroupReservationsApi->create_group_reservation_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **group_reservation_input** | [**GroupReservationInput**](GroupReservationInput.md) |  |  |

### Return type

[**GroupReservation**](GroupReservation.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json


## delete_group_reservation

> <DeleteGroupReservation200Response> delete_group_reservation(id)

Delete group reservation

Deletes or deactivates a group reservation. If the reservation is pending (not yet started), it will be permanently deleted. If it's already active, it will be deactivated and the person will be removed from the assigned groups. 

### Examples

```ruby
require 'time'
require 'doorflow-api'
# setup authorization
DoorFlow.configure do |config|
  # Configure OAuth2 access token for authorization: OAuth2
  config.access_token = 'YOUR ACCESS TOKEN'
end

api_instance = DoorFlow::GroupReservationsApi.new
id = 56 # Integer | Group reservation ID

begin
  # Delete group reservation
  result = api_instance.delete_group_reservation(id)
  p result
rescue DoorFlow::ApiError => e
  puts "Error when calling GroupReservationsApi->delete_group_reservation: #{e}"
end
```

#### Using the delete_group_reservation_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<DeleteGroupReservation200Response>, Integer, Hash)> delete_group_reservation_with_http_info(id)

```ruby
begin
  # Delete group reservation
  data, status_code, headers = api_instance.delete_group_reservation_with_http_info(id)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <DeleteGroupReservation200Response>
rescue DoorFlow::ApiError => e
  puts "Error when calling GroupReservationsApi->delete_group_reservation_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **id** | **Integer** | Group reservation ID |  |

### Return type

[**DeleteGroupReservation200Response**](DeleteGroupReservation200Response.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## list_group_reservations

> <Array<GroupReservation>> list_group_reservations(opts)

List group reservations

Returns a paginated list of present and future group reservations. Group reservations temporarily assign people to groups for a specified time period. Supports incremental sync via `since` or `since_utc` parameters. 

### Examples

```ruby
require 'time'
require 'doorflow-api'
# setup authorization
DoorFlow.configure do |config|
  # Configure OAuth2 access token for authorization: OAuth2
  config.access_token = 'YOUR ACCESS TOKEN'
end

api_instance = DoorFlow::GroupReservationsApi.new
opts = {
  since: Time.parse('2013-10-20T19:20:30+01:00'), # Time | Return only group reservations updated since this timestamp (local time)
  since_utc: Time.parse('2013-10-20T19:20:30+01:00'), # Time | Return only group reservations updated since this timestamp (UTC)
  per_page: 56, # Integer | Number of results per page
  page: 56, # Integer | Page number for pagination
  skip_pagination: true # Boolean | Skip pagination and return all results
}

begin
  # List group reservations
  result = api_instance.list_group_reservations(opts)
  p result
rescue DoorFlow::ApiError => e
  puts "Error when calling GroupReservationsApi->list_group_reservations: #{e}"
end
```

#### Using the list_group_reservations_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<Array<GroupReservation>>, Integer, Hash)> list_group_reservations_with_http_info(opts)

```ruby
begin
  # List group reservations
  data, status_code, headers = api_instance.list_group_reservations_with_http_info(opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <Array<GroupReservation>>
rescue DoorFlow::ApiError => e
  puts "Error when calling GroupReservationsApi->list_group_reservations_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **since** | **Time** | Return only group reservations updated since this timestamp (local time) | [optional] |
| **since_utc** | **Time** | Return only group reservations updated since this timestamp (UTC) | [optional] |
| **per_page** | **Integer** | Number of results per page | [optional][default to 500] |
| **page** | **Integer** | Page number for pagination | [optional][default to 1] |
| **skip_pagination** | **Boolean** | Skip pagination and return all results | [optional] |

### Return type

[**Array&lt;GroupReservation&gt;**](GroupReservation.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

