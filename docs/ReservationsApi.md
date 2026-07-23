# DoorFlow::ReservationsApi

All URIs are relative to *https://api.doorflow.com*

| Method | HTTP request | Description |
| ------ | ------------ | ----------- |
| [**create_reservation**](ReservationsApi.md#create_reservation) | **POST** /api/3/reservations | Create reservation |
| [**delete_reservation**](ReservationsApi.md#delete_reservation) | **DELETE** /api/3/reservations/{id} | Delete reservation |
| [**list_reservations**](ReservationsApi.md#list_reservations) | **GET** /api/3/reservations | List reservations |


## create_reservation

> <Reservation> create_reservation(reservation_input)

Create reservation

Creates a new reservation to grant temporary access to specific channels for a person. The start and end times must fall on the same day in the account's time zone. Automatically creates a role and shift for the reservation period. 

### Examples

```ruby
require 'time'
require 'doorflow-api'
# setup authorization
DoorFlow.configure do |config|
  # Configure OAuth2 access token for authorization: OAuth2
  config.access_token = 'YOUR ACCESS TOKEN'
end

api_instance = DoorFlow::ReservationsApi.new
reservation_input = DoorFlow::ReservationInput.new({person_id: 12345, start_time: Time.parse('2024-01-15T09:00Z'), end_time: Time.parse('2024-01-15T17:00Z')}) # ReservationInput | 

begin
  # Create reservation
  result = api_instance.create_reservation(reservation_input)
  p result
rescue DoorFlow::ApiError => e
  puts "Error when calling ReservationsApi->create_reservation: #{e}"
end
```

#### Using the create_reservation_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<Reservation>, Integer, Hash)> create_reservation_with_http_info(reservation_input)

```ruby
begin
  # Create reservation
  data, status_code, headers = api_instance.create_reservation_with_http_info(reservation_input)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <Reservation>
rescue DoorFlow::ApiError => e
  puts "Error when calling ReservationsApi->create_reservation_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **reservation_input** | [**ReservationInput**](ReservationInput.md) |  |  |

### Return type

[**Reservation**](Reservation.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json


## delete_reservation

> <DeleteCardDesign200Response> delete_reservation(id)

Delete reservation

Deletes a reservation, removing the temporary access grant. This will also delete the associated role and shift. 

### Examples

```ruby
require 'time'
require 'doorflow-api'
# setup authorization
DoorFlow.configure do |config|
  # Configure OAuth2 access token for authorization: OAuth2
  config.access_token = 'YOUR ACCESS TOKEN'
end

api_instance = DoorFlow::ReservationsApi.new
id = 56 # Integer | Reservation ID

begin
  # Delete reservation
  result = api_instance.delete_reservation(id)
  p result
rescue DoorFlow::ApiError => e
  puts "Error when calling ReservationsApi->delete_reservation: #{e}"
end
```

#### Using the delete_reservation_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<DeleteCardDesign200Response>, Integer, Hash)> delete_reservation_with_http_info(id)

```ruby
begin
  # Delete reservation
  data, status_code, headers = api_instance.delete_reservation_with_http_info(id)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <DeleteCardDesign200Response>
rescue DoorFlow::ApiError => e
  puts "Error when calling ReservationsApi->delete_reservation_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **id** | **Integer** | Reservation ID |  |

### Return type

[**DeleteCardDesign200Response**](DeleteCardDesign200Response.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## list_reservations

> <Array<Reservation>> list_reservations(opts)

List reservations

Returns a paginated list of future reservations. Reservations grant temporary access to specific channels (door controllers) for a person within a specified time window. Supports incremental sync via `since` or `since_utc` parameters. 

### Examples

```ruby
require 'time'
require 'doorflow-api'
# setup authorization
DoorFlow.configure do |config|
  # Configure OAuth2 access token for authorization: OAuth2
  config.access_token = 'YOUR ACCESS TOKEN'
end

api_instance = DoorFlow::ReservationsApi.new
opts = {
  since: Time.parse('2013-10-20T19:20:30+01:00'), # Time | Return only reservations updated since this timestamp (local time)
  since_utc: Time.parse('2013-10-20T19:20:30+01:00'), # Time | Return only reservations updated since this timestamp (UTC)
  per_page: 56, # Integer | Number of results per page
  page: 56, # Integer | Page number for pagination
  skip_pagination: true # Boolean | Skip pagination and return all results
}

begin
  # List reservations
  result = api_instance.list_reservations(opts)
  p result
rescue DoorFlow::ApiError => e
  puts "Error when calling ReservationsApi->list_reservations: #{e}"
end
```

#### Using the list_reservations_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<Array<Reservation>>, Integer, Hash)> list_reservations_with_http_info(opts)

```ruby
begin
  # List reservations
  data, status_code, headers = api_instance.list_reservations_with_http_info(opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <Array<Reservation>>
rescue DoorFlow::ApiError => e
  puts "Error when calling ReservationsApi->list_reservations_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **since** | **Time** | Return only reservations updated since this timestamp (local time) | [optional] |
| **since_utc** | **Time** | Return only reservations updated since this timestamp (UTC) | [optional] |
| **per_page** | **Integer** | Number of results per page | [optional][default to 500] |
| **page** | **Integer** | Page number for pagination | [optional][default to 1] |
| **skip_pagination** | **Boolean** | Skip pagination and return all results | [optional] |

### Return type

[**Array&lt;Reservation&gt;**](Reservation.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

