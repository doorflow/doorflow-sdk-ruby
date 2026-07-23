# DoorFlow::PeopleApi

All URIs are relative to *https://api.doorflow.com*

| Method | HTTP request | Description |
| ------ | ------------ | ----------- |
| [**create_person**](PeopleApi.md#create_person) | **POST** /api/3/people | Create person |
| [**delete_person**](PeopleApi.md#delete_person) | **DELETE** /api/3/people/{id} | Delete person |
| [**get_person**](PeopleApi.md#get_person) | **GET** /api/3/people/{id} | Get person details |
| [**list_people**](PeopleApi.md#list_people) | **GET** /api/3/people | List people |
| [**update_person**](PeopleApi.md#update_person) | **PUT** /api/3/people/{id} | Update person |


## create_person

> <Person> create_person(person_input)

Create person

Creates a new person record with optional group and role assignments

### Examples

```ruby
require 'time'
require 'doorflow-api'
# setup authorization
DoorFlow.configure do |config|
  # Configure OAuth2 access token for authorization: OAuth2
  config.access_token = 'YOUR ACCESS TOKEN'
end

api_instance = DoorFlow::PeopleApi.new
person_input = DoorFlow::PersonInput.new # PersonInput | 

begin
  # Create person
  result = api_instance.create_person(person_input)
  p result
rescue DoorFlow::ApiError => e
  puts "Error when calling PeopleApi->create_person: #{e}"
end
```

#### Using the create_person_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<Person>, Integer, Hash)> create_person_with_http_info(person_input)

```ruby
begin
  # Create person
  data, status_code, headers = api_instance.create_person_with_http_info(person_input)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <Person>
rescue DoorFlow::ApiError => e
  puts "Error when calling PeopleApi->create_person_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **person_input** | [**PersonInput**](PersonInput.md) |  |  |

### Return type

[**Person**](Person.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json


## delete_person

> <DeleteCardDesign200Response> delete_person(id)

Delete person

Soft-deletes a person record. This removes them from the system but retains audit trail.

### Examples

```ruby
require 'time'
require 'doorflow-api'
# setup authorization
DoorFlow.configure do |config|
  # Configure OAuth2 access token for authorization: OAuth2
  config.access_token = 'YOUR ACCESS TOKEN'
end

api_instance = DoorFlow::PeopleApi.new
id = 56 # Integer | Person ID

begin
  # Delete person
  result = api_instance.delete_person(id)
  p result
rescue DoorFlow::ApiError => e
  puts "Error when calling PeopleApi->delete_person: #{e}"
end
```

#### Using the delete_person_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<DeleteCardDesign200Response>, Integer, Hash)> delete_person_with_http_info(id)

```ruby
begin
  # Delete person
  data, status_code, headers = api_instance.delete_person_with_http_info(id)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <DeleteCardDesign200Response>
rescue DoorFlow::ApiError => e
  puts "Error when calling PeopleApi->delete_person_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **id** | **Integer** | Person ID |  |

### Return type

[**DeleteCardDesign200Response**](DeleteCardDesign200Response.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## get_person

> <Person> get_person(id)

Get person details

Returns details for a specific person

### Examples

```ruby
require 'time'
require 'doorflow-api'
# setup authorization
DoorFlow.configure do |config|
  # Configure OAuth2 access token for authorization: OAuth2
  config.access_token = 'YOUR ACCESS TOKEN'
end

api_instance = DoorFlow::PeopleApi.new
id = 56 # Integer | Person ID

begin
  # Get person details
  result = api_instance.get_person(id)
  p result
rescue DoorFlow::ApiError => e
  puts "Error when calling PeopleApi->get_person: #{e}"
end
```

#### Using the get_person_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<Person>, Integer, Hash)> get_person_with_http_info(id)

```ruby
begin
  # Get person details
  data, status_code, headers = api_instance.get_person_with_http_info(id)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <Person>
rescue DoorFlow::ApiError => e
  puts "Error when calling PeopleApi->get_person_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **id** | **Integer** | Person ID |  |

### Return type

[**Person**](Person.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## list_people

> <Array<Person>> list_people(opts)

List people

Returns a paginated list of people accessible to the authenticated user. Supports incremental sync via `since` or `since_utc` parameters.

### Examples

```ruby
require 'time'
require 'doorflow-api'
# setup authorization
DoorFlow.configure do |config|
  # Configure OAuth2 access token for authorization: OAuth2
  config.access_token = 'YOUR ACCESS TOKEN'
end

api_instance = DoorFlow::PeopleApi.new
opts = {
  email: 'email_example', # String | Filter by email (case-insensitive partial match)
  system_id: 'system_id_example', # String | Filter by organisation system ID
  since: Time.parse('2013-10-20T19:20:30+01:00'), # Time | Return only people updated since this timestamp (local time)
  since_utc: Time.parse('2013-10-20T19:20:30+01:00'), # Time | Return only people updated since this timestamp (UTC)
  per_page: 56, # Integer | Number of results per page
  page: 56, # Integer | Page number for pagination
  skip_pagination: true # Boolean | Skip pagination and return all results
}

begin
  # List people
  result = api_instance.list_people(opts)
  p result
rescue DoorFlow::ApiError => e
  puts "Error when calling PeopleApi->list_people: #{e}"
end
```

#### Using the list_people_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<Array<Person>>, Integer, Hash)> list_people_with_http_info(opts)

```ruby
begin
  # List people
  data, status_code, headers = api_instance.list_people_with_http_info(opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <Array<Person>>
rescue DoorFlow::ApiError => e
  puts "Error when calling PeopleApi->list_people_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **email** | **String** | Filter by email (case-insensitive partial match) | [optional] |
| **system_id** | **String** | Filter by organisation system ID | [optional] |
| **since** | **Time** | Return only people updated since this timestamp (local time) | [optional] |
| **since_utc** | **Time** | Return only people updated since this timestamp (UTC) | [optional] |
| **per_page** | **Integer** | Number of results per page | [optional][default to 50] |
| **page** | **Integer** | Page number for pagination | [optional][default to 1] |
| **skip_pagination** | **Boolean** | Skip pagination and return all results | [optional] |

### Return type

[**Array&lt;Person&gt;**](Person.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## update_person

> <Person> update_person(id, person_input)

Update person

Updates an existing person record. Can modify group and role assignments. Setting `image_remote_url` to empty string will delete the image.

### Examples

```ruby
require 'time'
require 'doorflow-api'
# setup authorization
DoorFlow.configure do |config|
  # Configure OAuth2 access token for authorization: OAuth2
  config.access_token = 'YOUR ACCESS TOKEN'
end

api_instance = DoorFlow::PeopleApi.new
id = 56 # Integer | Person ID
person_input = DoorFlow::PersonInput.new # PersonInput | 

begin
  # Update person
  result = api_instance.update_person(id, person_input)
  p result
rescue DoorFlow::ApiError => e
  puts "Error when calling PeopleApi->update_person: #{e}"
end
```

#### Using the update_person_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<Person>, Integer, Hash)> update_person_with_http_info(id, person_input)

```ruby
begin
  # Update person
  data, status_code, headers = api_instance.update_person_with_http_info(id, person_input)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <Person>
rescue DoorFlow::ApiError => e
  puts "Error when calling PeopleApi->update_person_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **id** | **Integer** | Person ID |  |
| **person_input** | [**PersonInput**](PersonInput.md) |  |  |

### Return type

[**Person**](Person.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json

