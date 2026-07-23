# DoorFlow::CardTemplatesApi

All URIs are relative to *https://api.doorflow.com*

| Method | HTTP request | Description |
| ------ | ------------ | ----------- |
| [**create_card_template**](CardTemplatesApi.md#create_card_template) | **POST** /api/3/card_templates | Create card template |
| [**delete_card_template**](CardTemplatesApi.md#delete_card_template) | **DELETE** /api/3/card_templates/{id} | Delete card template (hard-delete) |
| [**delete_card_template_background_image**](CardTemplatesApi.md#delete_card_template_background_image) | **DELETE** /api/3/card_templates/{id}/background_image/{side} | Delete background image |
| [**delete_card_template_file**](CardTemplatesApi.md#delete_card_template_file) | **DELETE** /api/3/card_templates/{id}/files/{file_uuid} | Delete linked file |
| [**get_card_template**](CardTemplatesApi.md#get_card_template) | **GET** /api/3/card_templates/{id} | Get card template |
| [**get_card_template_background_image**](CardTemplatesApi.md#get_card_template_background_image) | **GET** /api/3/card_templates/{id}/background_image/{side} | Get background image |
| [**list_card_template_files**](CardTemplatesApi.md#list_card_template_files) | **GET** /api/3/card_templates/{id}/files | List linked files |
| [**list_card_templates**](CardTemplatesApi.md#list_card_templates) | **GET** /api/3/card_templates | List card templates |
| [**update_card_template**](CardTemplatesApi.md#update_card_template) | **PUT** /api/3/card_templates/{id} | Update card template |
| [**update_card_template_background_image**](CardTemplatesApi.md#update_card_template_background_image) | **PUT** /api/3/card_templates/{id}/background_image/{side} | Upload background image |
| [**upload_card_template_file**](CardTemplatesApi.md#upload_card_template_file) | **PUT** /api/3/card_templates/{id}/files/{file_uuid} | Upload or replace linked file |


## create_card_template

> <CardTemplate> create_card_template(card_template_input)

Create card template

Creates a new card template. The client should submit a locally generated uuid. The server preserves this and returns the server-assigned id. 

### Examples

```ruby
require 'time'
require 'doorflow-api'
# setup authorization
DoorFlow.configure do |config|
  # Configure OAuth2 access token for authorization: OAuth2
  config.access_token = 'YOUR ACCESS TOKEN'
end

api_instance = DoorFlow::CardTemplatesApi.new
card_template_input = DoorFlow::CardTemplateInput.new # CardTemplateInput | 

begin
  # Create card template
  result = api_instance.create_card_template(card_template_input)
  p result
rescue DoorFlow::ApiError => e
  puts "Error when calling CardTemplatesApi->create_card_template: #{e}"
end
```

#### Using the create_card_template_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<CardTemplate>, Integer, Hash)> create_card_template_with_http_info(card_template_input)

```ruby
begin
  # Create card template
  data, status_code, headers = api_instance.create_card_template_with_http_info(card_template_input)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <CardTemplate>
rescue DoorFlow::ApiError => e
  puts "Error when calling CardTemplatesApi->create_card_template_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **card_template_input** | [**CardTemplateInput**](CardTemplateInput.md) |  |  |

### Return type

[**CardTemplate**](CardTemplate.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json


## delete_card_template

> delete_card_template(id)

Delete card template (hard-delete)

Permanently deletes a card template and all associated template elements and background images. The record is removed from the database and cannot be restored. Permitted for any admin in the account.  For a recoverable delete, PATCH `deleted_at` instead. 

### Examples

```ruby
require 'time'
require 'doorflow-api'
# setup authorization
DoorFlow.configure do |config|
  # Configure OAuth2 access token for authorization: OAuth2
  config.access_token = 'YOUR ACCESS TOKEN'
end

api_instance = DoorFlow::CardTemplatesApi.new
id = 56 # Integer | Card template ID

begin
  # Delete card template (hard-delete)
  api_instance.delete_card_template(id)
rescue DoorFlow::ApiError => e
  puts "Error when calling CardTemplatesApi->delete_card_template: #{e}"
end
```

#### Using the delete_card_template_with_http_info variant

This returns an Array which contains the response data (`nil` in this case), status code and headers.

> <Array(nil, Integer, Hash)> delete_card_template_with_http_info(id)

```ruby
begin
  # Delete card template (hard-delete)
  data, status_code, headers = api_instance.delete_card_template_with_http_info(id)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => nil
rescue DoorFlow::ApiError => e
  puts "Error when calling CardTemplatesApi->delete_card_template_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **id** | **Integer** | Card template ID |  |

### Return type

nil (empty response body)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## delete_card_template_background_image

> delete_card_template_background_image(id, side)

Delete background image

Removes the background image for the specified side.

### Examples

```ruby
require 'time'
require 'doorflow-api'
# setup authorization
DoorFlow.configure do |config|
  # Configure OAuth2 access token for authorization: OAuth2
  config.access_token = 'YOUR ACCESS TOKEN'
end

api_instance = DoorFlow::CardTemplatesApi.new
id = 56 # Integer | Card template ID
side = 'front' # String | Which side of the card

begin
  # Delete background image
  api_instance.delete_card_template_background_image(id, side)
rescue DoorFlow::ApiError => e
  puts "Error when calling CardTemplatesApi->delete_card_template_background_image: #{e}"
end
```

#### Using the delete_card_template_background_image_with_http_info variant

This returns an Array which contains the response data (`nil` in this case), status code and headers.

> <Array(nil, Integer, Hash)> delete_card_template_background_image_with_http_info(id, side)

```ruby
begin
  # Delete background image
  data, status_code, headers = api_instance.delete_card_template_background_image_with_http_info(id, side)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => nil
rescue DoorFlow::ApiError => e
  puts "Error when calling CardTemplatesApi->delete_card_template_background_image_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **id** | **Integer** | Card template ID |  |
| **side** | **String** | Which side of the card |  |

### Return type

nil (empty response body)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## delete_card_template_file

> delete_card_template_file(id, file_uuid)

Delete linked file

Removes a linked file from a card template.

### Examples

```ruby
require 'time'
require 'doorflow-api'
# setup authorization
DoorFlow.configure do |config|
  # Configure OAuth2 access token for authorization: OAuth2
  config.access_token = 'YOUR ACCESS TOKEN'
end

api_instance = DoorFlow::CardTemplatesApi.new
id = 56 # Integer | Card template ID
file_uuid = 'file_uuid_example' # String | UUID of the linked file

begin
  # Delete linked file
  api_instance.delete_card_template_file(id, file_uuid)
rescue DoorFlow::ApiError => e
  puts "Error when calling CardTemplatesApi->delete_card_template_file: #{e}"
end
```

#### Using the delete_card_template_file_with_http_info variant

This returns an Array which contains the response data (`nil` in this case), status code and headers.

> <Array(nil, Integer, Hash)> delete_card_template_file_with_http_info(id, file_uuid)

```ruby
begin
  # Delete linked file
  data, status_code, headers = api_instance.delete_card_template_file_with_http_info(id, file_uuid)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => nil
rescue DoorFlow::ApiError => e
  puts "Error when calling CardTemplatesApi->delete_card_template_file_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **id** | **Integer** | Card template ID |  |
| **file_uuid** | **String** | UUID of the linked file |  |

### Return type

nil (empty response body)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## get_card_template

> <CardTemplate> get_card_template(id)

Get card template

Returns a single card template by ID including all template elements.

### Examples

```ruby
require 'time'
require 'doorflow-api'
# setup authorization
DoorFlow.configure do |config|
  # Configure OAuth2 access token for authorization: OAuth2
  config.access_token = 'YOUR ACCESS TOKEN'
end

api_instance = DoorFlow::CardTemplatesApi.new
id = 56 # Integer | Card template ID

begin
  # Get card template
  result = api_instance.get_card_template(id)
  p result
rescue DoorFlow::ApiError => e
  puts "Error when calling CardTemplatesApi->get_card_template: #{e}"
end
```

#### Using the get_card_template_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<CardTemplate>, Integer, Hash)> get_card_template_with_http_info(id)

```ruby
begin
  # Get card template
  data, status_code, headers = api_instance.get_card_template_with_http_info(id)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <CardTemplate>
rescue DoorFlow::ApiError => e
  puts "Error when calling CardTemplatesApi->get_card_template_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **id** | **Integer** | Card template ID |  |

### Return type

[**CardTemplate**](CardTemplate.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## get_card_template_background_image

> get_card_template_background_image(id, side)

Get background image

Returns the background image for the specified side. Redirects to the image URL.

### Examples

```ruby
require 'time'
require 'doorflow-api'
# setup authorization
DoorFlow.configure do |config|
  # Configure OAuth2 access token for authorization: OAuth2
  config.access_token = 'YOUR ACCESS TOKEN'
end

api_instance = DoorFlow::CardTemplatesApi.new
id = 56 # Integer | Card template ID
side = 'front' # String | Which side of the card

begin
  # Get background image
  api_instance.get_card_template_background_image(id, side)
rescue DoorFlow::ApiError => e
  puts "Error when calling CardTemplatesApi->get_card_template_background_image: #{e}"
end
```

#### Using the get_card_template_background_image_with_http_info variant

This returns an Array which contains the response data (`nil` in this case), status code and headers.

> <Array(nil, Integer, Hash)> get_card_template_background_image_with_http_info(id, side)

```ruby
begin
  # Get background image
  data, status_code, headers = api_instance.get_card_template_background_image_with_http_info(id, side)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => nil
rescue DoorFlow::ApiError => e
  puts "Error when calling CardTemplatesApi->get_card_template_background_image_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **id** | **Integer** | Card template ID |  |
| **side** | **String** | Which side of the card |  |

### Return type

nil (empty response body)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## list_card_template_files

> <Array<LinkedFile>> list_card_template_files(id)

List linked files

Returns all files linked to a card template.

### Examples

```ruby
require 'time'
require 'doorflow-api'
# setup authorization
DoorFlow.configure do |config|
  # Configure OAuth2 access token for authorization: OAuth2
  config.access_token = 'YOUR ACCESS TOKEN'
end

api_instance = DoorFlow::CardTemplatesApi.new
id = 56 # Integer | Card template ID

begin
  # List linked files
  result = api_instance.list_card_template_files(id)
  p result
rescue DoorFlow::ApiError => e
  puts "Error when calling CardTemplatesApi->list_card_template_files: #{e}"
end
```

#### Using the list_card_template_files_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<Array<LinkedFile>>, Integer, Hash)> list_card_template_files_with_http_info(id)

```ruby
begin
  # List linked files
  data, status_code, headers = api_instance.list_card_template_files_with_http_info(id)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <Array<LinkedFile>>
rescue DoorFlow::ApiError => e
  puts "Error when calling CardTemplatesApi->list_card_template_files_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **id** | **Integer** | Card template ID |  |

### Return type

[**Array&lt;LinkedFile&gt;**](LinkedFile.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## list_card_templates

> <Array<CardTemplate>> list_card_templates(opts)

List card templates

Returns a paginated list of card templates for the authenticated account. Soft-deleted templates (deleted_at is not null) are excluded by default; pass include_deleted=true to include them. 

### Examples

```ruby
require 'time'
require 'doorflow-api'
# setup authorization
DoorFlow.configure do |config|
  # Configure OAuth2 access token for authorization: OAuth2
  config.access_token = 'YOUR ACCESS TOKEN'
end

api_instance = DoorFlow::CardTemplatesApi.new
opts = {
  page: 56, # Integer | Page number
  per_page: 56, # Integer | Results per page
  updated_since: Time.parse('2013-10-20T19:20:30+01:00'), # Time | ISO 8601 timestamp. Returns only records updated after this time
  include_deleted: true # Boolean | When true, soft-deleted templates are included in the response. Defaults to false. 
}

begin
  # List card templates
  result = api_instance.list_card_templates(opts)
  p result
rescue DoorFlow::ApiError => e
  puts "Error when calling CardTemplatesApi->list_card_templates: #{e}"
end
```

#### Using the list_card_templates_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<Array<CardTemplate>>, Integer, Hash)> list_card_templates_with_http_info(opts)

```ruby
begin
  # List card templates
  data, status_code, headers = api_instance.list_card_templates_with_http_info(opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <Array<CardTemplate>>
rescue DoorFlow::ApiError => e
  puts "Error when calling CardTemplatesApi->list_card_templates_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **page** | **Integer** | Page number | [optional][default to 1] |
| **per_page** | **Integer** | Results per page | [optional][default to 50] |
| **updated_since** | **Time** | ISO 8601 timestamp. Returns only records updated after this time | [optional] |
| **include_deleted** | **Boolean** | When true, soft-deleted templates are included in the response. Defaults to false.  | [optional][default to false] |

### Return type

[**Array&lt;CardTemplate&gt;**](CardTemplate.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## update_card_template

> <CardTemplate> update_card_template(id, card_template_input)

Update card template

Updates an existing card template. Submitting template_objects replaces the entire objects array.  Three special update modes are recognised: - **Soft-delete**: PATCH `deleted_at` to a non-null timestamp to   soft-delete (or null to restore). The server records `deleted_by_id`   from the authenticated user. Soft-delete is permitted for any admin   in the account, regardless of `editable_by` or `owner_id`. - **Owner transfer**: PATCH `owner_id` to reassign ownership. Permitted   for the current owner or any admin in the account. The new value must   be the ID of an admin in the same account. - **Content edits** (any other writable field): respect the existing   `editable_by` rule; if `editable_by` is `owner_only`, only the   current owner may edit. 

### Examples

```ruby
require 'time'
require 'doorflow-api'
# setup authorization
DoorFlow.configure do |config|
  # Configure OAuth2 access token for authorization: OAuth2
  config.access_token = 'YOUR ACCESS TOKEN'
end

api_instance = DoorFlow::CardTemplatesApi.new
id = 56 # Integer | Card template ID
card_template_input = DoorFlow::CardTemplateInput.new # CardTemplateInput | 

begin
  # Update card template
  result = api_instance.update_card_template(id, card_template_input)
  p result
rescue DoorFlow::ApiError => e
  puts "Error when calling CardTemplatesApi->update_card_template: #{e}"
end
```

#### Using the update_card_template_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<CardTemplate>, Integer, Hash)> update_card_template_with_http_info(id, card_template_input)

```ruby
begin
  # Update card template
  data, status_code, headers = api_instance.update_card_template_with_http_info(id, card_template_input)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <CardTemplate>
rescue DoorFlow::ApiError => e
  puts "Error when calling CardTemplatesApi->update_card_template_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **id** | **Integer** | Card template ID |  |
| **card_template_input** | [**CardTemplateInput**](CardTemplateInput.md) |  |  |

### Return type

[**CardTemplate**](CardTemplate.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json


## update_card_template_background_image

> <CardTemplate> update_card_template_background_image(id, side, body)

Upload background image

Uploads or replaces the background image for the specified side.

### Examples

```ruby
require 'time'
require 'doorflow-api'
# setup authorization
DoorFlow.configure do |config|
  # Configure OAuth2 access token for authorization: OAuth2
  config.access_token = 'YOUR ACCESS TOKEN'
end

api_instance = DoorFlow::CardTemplatesApi.new
id = 56 # Integer | Card template ID
side = 'front' # String | Which side of the card
body = File.new('/path/to/some/file') # File | 

begin
  # Upload background image
  result = api_instance.update_card_template_background_image(id, side, body)
  p result
rescue DoorFlow::ApiError => e
  puts "Error when calling CardTemplatesApi->update_card_template_background_image: #{e}"
end
```

#### Using the update_card_template_background_image_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<CardTemplate>, Integer, Hash)> update_card_template_background_image_with_http_info(id, side, body)

```ruby
begin
  # Upload background image
  data, status_code, headers = api_instance.update_card_template_background_image_with_http_info(id, side, body)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <CardTemplate>
rescue DoorFlow::ApiError => e
  puts "Error when calling CardTemplatesApi->update_card_template_background_image_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **id** | **Integer** | Card template ID |  |
| **side** | **String** | Which side of the card |  |
| **body** | **File** |  |  |

### Return type

[**CardTemplate**](CardTemplate.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

- **Content-Type**: image/png, image/jpeg
- **Accept**: application/json


## upload_card_template_file

> <LinkedFile> upload_card_template_file(id, file_uuid, file_role, body)

Upload or replace linked file

Uploads or replaces a linked file for a card template. The file_role query parameter is required.

### Examples

```ruby
require 'time'
require 'doorflow-api'
# setup authorization
DoorFlow.configure do |config|
  # Configure OAuth2 access token for authorization: OAuth2
  config.access_token = 'YOUR ACCESS TOKEN'
end

api_instance = DoorFlow::CardTemplatesApi.new
id = 56 # Integer | Card template ID
file_uuid = 'file_uuid_example' # String | UUID of the linked file
file_role = 'file_role_example' # String | Role of the file (e.g. background_front, background_back, logo)
body = File.new('/path/to/some/file') # File | 

begin
  # Upload or replace linked file
  result = api_instance.upload_card_template_file(id, file_uuid, file_role, body)
  p result
rescue DoorFlow::ApiError => e
  puts "Error when calling CardTemplatesApi->upload_card_template_file: #{e}"
end
```

#### Using the upload_card_template_file_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<LinkedFile>, Integer, Hash)> upload_card_template_file_with_http_info(id, file_uuid, file_role, body)

```ruby
begin
  # Upload or replace linked file
  data, status_code, headers = api_instance.upload_card_template_file_with_http_info(id, file_uuid, file_role, body)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <LinkedFile>
rescue DoorFlow::ApiError => e
  puts "Error when calling CardTemplatesApi->upload_card_template_file_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **id** | **Integer** | Card template ID |  |
| **file_uuid** | **String** | UUID of the linked file |  |
| **file_role** | **String** | Role of the file (e.g. background_front, background_back, logo) |  |
| **body** | **File** |  |  |

### Return type

[**LinkedFile**](LinkedFile.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

- **Content-Type**: application/octet-stream
- **Accept**: application/json

