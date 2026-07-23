# DoorFlow::CardDesignsApi

All URIs are relative to *https://api.doorflow.com*

| Method | HTTP request | Description |
| ------ | ------------ | ----------- |
| [**create_card_design**](CardDesignsApi.md#create_card_design) | **POST** /api/3/card_designs | Create card design |
| [**delete_card_design**](CardDesignsApi.md#delete_card_design) | **DELETE** /api/3/card_designs/{id} | Delete card design |
| [**get_card_design**](CardDesignsApi.md#get_card_design) | **GET** /api/3/card_designs/{id} | Get card design |
| [**list_card_designs**](CardDesignsApi.md#list_card_designs) | **GET** /api/3/card_designs | List card designs |
| [**update_card_design**](CardDesignsApi.md#update_card_design) | **PUT** /api/3/card_designs/{id} | Update card design |


## create_card_design

> <CardDesign> create_card_design(card_design_input)

Create card design

Creates a new card design. Images can be provided as base64-encoded strings.

### Examples

```ruby
require 'time'
require 'doorflow-api'
# setup authorization
DoorFlow.configure do |config|
  # Configure OAuth2 access token for authorization: OAuth2
  config.access_token = 'YOUR ACCESS TOKEN'
end

api_instance = DoorFlow::CardDesignsApi.new
card_design_input = DoorFlow::CardDesignInput.new # CardDesignInput | 

begin
  # Create card design
  result = api_instance.create_card_design(card_design_input)
  p result
rescue DoorFlow::ApiError => e
  puts "Error when calling CardDesignsApi->create_card_design: #{e}"
end
```

#### Using the create_card_design_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<CardDesign>, Integer, Hash)> create_card_design_with_http_info(card_design_input)

```ruby
begin
  # Create card design
  data, status_code, headers = api_instance.create_card_design_with_http_info(card_design_input)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <CardDesign>
rescue DoorFlow::ApiError => e
  puts "Error when calling CardDesignsApi->create_card_design_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **card_design_input** | [**CardDesignInput**](CardDesignInput.md) |  |  |

### Return type

[**CardDesign**](CardDesign.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json


## delete_card_design

> <DeleteCardDesign200Response> delete_card_design(id)

Delete card design

Permanently deletes a card design and its associated images.

### Examples

```ruby
require 'time'
require 'doorflow-api'
# setup authorization
DoorFlow.configure do |config|
  # Configure OAuth2 access token for authorization: OAuth2
  config.access_token = 'YOUR ACCESS TOKEN'
end

api_instance = DoorFlow::CardDesignsApi.new
id = 56 # Integer | Card Design ID

begin
  # Delete card design
  result = api_instance.delete_card_design(id)
  p result
rescue DoorFlow::ApiError => e
  puts "Error when calling CardDesignsApi->delete_card_design: #{e}"
end
```

#### Using the delete_card_design_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<DeleteCardDesign200Response>, Integer, Hash)> delete_card_design_with_http_info(id)

```ruby
begin
  # Delete card design
  data, status_code, headers = api_instance.delete_card_design_with_http_info(id)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <DeleteCardDesign200Response>
rescue DoorFlow::ApiError => e
  puts "Error when calling CardDesignsApi->delete_card_design_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **id** | **Integer** | Card Design ID |  |

### Return type

[**DeleteCardDesign200Response**](DeleteCardDesign200Response.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## get_card_design

> <CardDesign> get_card_design(id)

Get card design

Returns details for a specific card design including image URLs at multiple sizes.

### Examples

```ruby
require 'time'
require 'doorflow-api'
# setup authorization
DoorFlow.configure do |config|
  # Configure OAuth2 access token for authorization: OAuth2
  config.access_token = 'YOUR ACCESS TOKEN'
end

api_instance = DoorFlow::CardDesignsApi.new
id = 56 # Integer | Card Design ID

begin
  # Get card design
  result = api_instance.get_card_design(id)
  p result
rescue DoorFlow::ApiError => e
  puts "Error when calling CardDesignsApi->get_card_design: #{e}"
end
```

#### Using the get_card_design_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<CardDesign>, Integer, Hash)> get_card_design_with_http_info(id)

```ruby
begin
  # Get card design
  data, status_code, headers = api_instance.get_card_design_with_http_info(id)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <CardDesign>
rescue DoorFlow::ApiError => e
  puts "Error when calling CardDesignsApi->get_card_design_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **id** | **Integer** | Card Design ID |  |

### Return type

[**CardDesign**](CardDesign.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## list_card_designs

> <Array<CardDesign>> list_card_designs

List card designs

Returns all card designs for the authenticated user's account.

### Examples

```ruby
require 'time'
require 'doorflow-api'
# setup authorization
DoorFlow.configure do |config|
  # Configure OAuth2 access token for authorization: OAuth2
  config.access_token = 'YOUR ACCESS TOKEN'
end

api_instance = DoorFlow::CardDesignsApi.new

begin
  # List card designs
  result = api_instance.list_card_designs
  p result
rescue DoorFlow::ApiError => e
  puts "Error when calling CardDesignsApi->list_card_designs: #{e}"
end
```

#### Using the list_card_designs_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<Array<CardDesign>>, Integer, Hash)> list_card_designs_with_http_info

```ruby
begin
  # List card designs
  data, status_code, headers = api_instance.list_card_designs_with_http_info
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <Array<CardDesign>>
rescue DoorFlow::ApiError => e
  puts "Error when calling CardDesignsApi->list_card_designs_with_http_info: #{e}"
end
```

### Parameters

This endpoint does not need any parameter.

### Return type

[**Array&lt;CardDesign&gt;**](CardDesign.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## update_card_design

> <CardDesign> update_card_design(id, card_design_input)

Update card design

Updates an existing card design. Images can be replaced by providing new base64-encoded strings.

### Examples

```ruby
require 'time'
require 'doorflow-api'
# setup authorization
DoorFlow.configure do |config|
  # Configure OAuth2 access token for authorization: OAuth2
  config.access_token = 'YOUR ACCESS TOKEN'
end

api_instance = DoorFlow::CardDesignsApi.new
id = 56 # Integer | Card Design ID
card_design_input = DoorFlow::CardDesignInput.new # CardDesignInput | 

begin
  # Update card design
  result = api_instance.update_card_design(id, card_design_input)
  p result
rescue DoorFlow::ApiError => e
  puts "Error when calling CardDesignsApi->update_card_design: #{e}"
end
```

#### Using the update_card_design_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<CardDesign>, Integer, Hash)> update_card_design_with_http_info(id, card_design_input)

```ruby
begin
  # Update card design
  data, status_code, headers = api_instance.update_card_design_with_http_info(id, card_design_input)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <CardDesign>
rescue DoorFlow::ApiError => e
  puts "Error when calling CardDesignsApi->update_card_design_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **id** | **Integer** | Card Design ID |  |
| **card_design_input** | [**CardDesignInput**](CardDesignInput.md) |  |  |

### Return type

[**CardDesign**](CardDesign.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json

