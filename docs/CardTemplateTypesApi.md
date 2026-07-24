# DoorFlow::CardTemplateTypesApi

All URIs are relative to *https://api.doorflow.com*

| Method | HTTP request | Description |
| ------ | ------------ | ----------- |
| [**create_card_template_type**](CardTemplateTypesApi.md#create_card_template_type) | **POST** /api/3/card_template_types | Create card template type |
| [**delete_card_template_type**](CardTemplateTypesApi.md#delete_card_template_type) | **DELETE** /api/3/card_template_types/{code} | Delete card template type |
| [**get_card_template_type**](CardTemplateTypesApi.md#get_card_template_type) | **GET** /api/3/card_template_types/{code} | Get card template type |
| [**list_card_template_types**](CardTemplateTypesApi.md#list_card_template_types) | **GET** /api/3/card_template_types | List card template types |
| [**update_card_template_type**](CardTemplateTypesApi.md#update_card_template_type) | **PUT** /api/3/card_template_types/{code} | Update card template type |


## create_card_template_type

> <CardTemplateType> create_card_template_type(card_template_type_input)

Create card template type

Creates a new card template type. The code field must be unique.

### Examples

```ruby
require 'time'
require 'doorflow-api'
# setup authorization
DoorFlow.configure do |config|
  # Configure OAuth2 access token for authorization: OAuth2
  config.access_token = 'YOUR ACCESS TOKEN'
end

api_instance = DoorFlow::CardTemplateTypesApi.new
card_template_type_input = DoorFlow::CardTemplateTypeInput.new # CardTemplateTypeInput | 

begin
  # Create card template type
  result = api_instance.create_card_template_type(card_template_type_input)
  p result
rescue DoorFlow::ApiError => e
  puts "Error when calling CardTemplateTypesApi->create_card_template_type: #{e}"
end
```

#### Using the create_card_template_type_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<CardTemplateType>, Integer, Hash)> create_card_template_type_with_http_info(card_template_type_input)

```ruby
begin
  # Create card template type
  data, status_code, headers = api_instance.create_card_template_type_with_http_info(card_template_type_input)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <CardTemplateType>
rescue DoorFlow::ApiError => e
  puts "Error when calling CardTemplateTypesApi->create_card_template_type_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **card_template_type_input** | [**CardTemplateTypeInput**](CardTemplateTypeInput.md) |  |  |

### Return type

[**CardTemplateType**](CardTemplateType.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json


## delete_card_template_type

> delete_card_template_type(code)

Delete card template type

Deletes a card template type. Fails with 409 Conflict if any card templates reference this type.

### Examples

```ruby
require 'time'
require 'doorflow-api'
# setup authorization
DoorFlow.configure do |config|
  # Configure OAuth2 access token for authorization: OAuth2
  config.access_token = 'YOUR ACCESS TOKEN'
end

api_instance = DoorFlow::CardTemplateTypesApi.new
code = 'code_example' # String | Card template type code

begin
  # Delete card template type
  api_instance.delete_card_template_type(code)
rescue DoorFlow::ApiError => e
  puts "Error when calling CardTemplateTypesApi->delete_card_template_type: #{e}"
end
```

#### Using the delete_card_template_type_with_http_info variant

This returns an Array which contains the response data (`nil` in this case), status code and headers.

> <Array(nil, Integer, Hash)> delete_card_template_type_with_http_info(code)

```ruby
begin
  # Delete card template type
  data, status_code, headers = api_instance.delete_card_template_type_with_http_info(code)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => nil
rescue DoorFlow::ApiError => e
  puts "Error when calling CardTemplateTypesApi->delete_card_template_type_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **code** | **String** | Card template type code |  |

### Return type

nil (empty response body)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## get_card_template_type

> <CardTemplateType> get_card_template_type(code)

Get card template type

Returns a single card template type by its code.

### Examples

```ruby
require 'time'
require 'doorflow-api'
# setup authorization
DoorFlow.configure do |config|
  # Configure OAuth2 access token for authorization: OAuth2
  config.access_token = 'YOUR ACCESS TOKEN'
end

api_instance = DoorFlow::CardTemplateTypesApi.new
code = 'code_example' # String | Card template type code

begin
  # Get card template type
  result = api_instance.get_card_template_type(code)
  p result
rescue DoorFlow::ApiError => e
  puts "Error when calling CardTemplateTypesApi->get_card_template_type: #{e}"
end
```

#### Using the get_card_template_type_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<CardTemplateType>, Integer, Hash)> get_card_template_type_with_http_info(code)

```ruby
begin
  # Get card template type
  data, status_code, headers = api_instance.get_card_template_type_with_http_info(code)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <CardTemplateType>
rescue DoorFlow::ApiError => e
  puts "Error when calling CardTemplateTypesApi->get_card_template_type_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **code** | **String** | Card template type code |  |

### Return type

[**CardTemplateType**](CardTemplateType.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## list_card_template_types

> <Array<CardTemplateType>> list_card_template_types(opts)

List card template types

Returns all available card template types. This endpoint is not paginated.

### Examples

```ruby
require 'time'
require 'doorflow-api'
# setup authorization
DoorFlow.configure do |config|
  # Configure OAuth2 access token for authorization: OAuth2
  config.access_token = 'YOUR ACCESS TOKEN'
end

api_instance = DoorFlow::CardTemplateTypesApi.new
opts = {
  updated_since: Time.parse('2013-10-20T19:20:30+01:00') # Time | ISO 8601 timestamp. Returns only types updated after this time
}

begin
  # List card template types
  result = api_instance.list_card_template_types(opts)
  p result
rescue DoorFlow::ApiError => e
  puts "Error when calling CardTemplateTypesApi->list_card_template_types: #{e}"
end
```

#### Using the list_card_template_types_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<Array<CardTemplateType>>, Integer, Hash)> list_card_template_types_with_http_info(opts)

```ruby
begin
  # List card template types
  data, status_code, headers = api_instance.list_card_template_types_with_http_info(opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <Array<CardTemplateType>>
rescue DoorFlow::ApiError => e
  puts "Error when calling CardTemplateTypesApi->list_card_template_types_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **updated_since** | **Time** | ISO 8601 timestamp. Returns only types updated after this time | [optional] |

### Return type

[**Array&lt;CardTemplateType&gt;**](CardTemplateType.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## update_card_template_type

> <CardTemplateType> update_card_template_type(code, card_template_type_input)

Update card template type

Updates an existing card template type. Submitting non_printable_zones replaces the entire zones array.

### Examples

```ruby
require 'time'
require 'doorflow-api'
# setup authorization
DoorFlow.configure do |config|
  # Configure OAuth2 access token for authorization: OAuth2
  config.access_token = 'YOUR ACCESS TOKEN'
end

api_instance = DoorFlow::CardTemplateTypesApi.new
code = 'code_example' # String | Card template type code
card_template_type_input = DoorFlow::CardTemplateTypeInput.new # CardTemplateTypeInput | 

begin
  # Update card template type
  result = api_instance.update_card_template_type(code, card_template_type_input)
  p result
rescue DoorFlow::ApiError => e
  puts "Error when calling CardTemplateTypesApi->update_card_template_type: #{e}"
end
```

#### Using the update_card_template_type_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<CardTemplateType>, Integer, Hash)> update_card_template_type_with_http_info(code, card_template_type_input)

```ruby
begin
  # Update card template type
  data, status_code, headers = api_instance.update_card_template_type_with_http_info(code, card_template_type_input)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <CardTemplateType>
rescue DoorFlow::ApiError => e
  puts "Error when calling CardTemplateTypesApi->update_card_template_type_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **code** | **String** | Card template type code |  |
| **card_template_type_input** | [**CardTemplateTypeInput**](CardTemplateTypeInput.md) |  |  |

### Return type

[**CardTemplateType**](CardTemplateType.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json

