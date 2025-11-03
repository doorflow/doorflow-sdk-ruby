# DoorFlow::CredentialsApi

All URIs are relative to *https://api.doorflow.com*

| Method | HTTP request | Description |
| ------ | ------------ | ----------- |
| [**create_credential**](CredentialsApi.md#create_credential) | **POST** /api/3/people/{person_id}/credentials | Create credential |
| [**delete_credential**](CredentialsApi.md#delete_credential) | **DELETE** /api/3/people/{person_id}/credentials/{id} | Delete credential |
| [**get_credential**](CredentialsApi.md#get_credential) | **GET** /api/3/people/{person_id}/credentials/{id} | Get credential details |
| [**list_all_credentials**](CredentialsApi.md#list_all_credentials) | **GET** /api/3/credentials | List all credentials |
| [**list_person_credentials**](CredentialsApi.md#list_person_credentials) | **GET** /api/3/people/{person_id}/credentials | List person credentials |
| [**update_credential**](CredentialsApi.md#update_credential) | **PUT** /api/3/people/{person_id}/credentials/{id} | Update credential |


## create_credential

> <Credential> create_credential(person_id, credential_input)

Create credential

Creates a new credential for a person. For HID Mobile Access and PassFlow credentials, this initiates an invitation process.

### Examples

```ruby
require 'time'
require 'doorflow-api'
# setup authorization
DoorFlow.configure do |config|
  # Configure OAuth2 access token for authorization: OAuth2
  config.access_token = 'YOUR ACCESS TOKEN'
end

api_instance = DoorFlow::CredentialsApi.new
person_id = 56 # Integer | Person ID
credential_input = DoorFlow::CredentialInput.new({person_credential: DoorFlow::CredentialInputPersonCredential.new({credential_type_id: 5})}) # CredentialInput | 

begin
  # Create credential
  result = api_instance.create_credential(person_id, credential_input)
  p result
rescue DoorFlow::ApiError => e
  puts "Error when calling CredentialsApi->create_credential: #{e}"
end
```

#### Using the create_credential_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<Credential>, Integer, Hash)> create_credential_with_http_info(person_id, credential_input)

```ruby
begin
  # Create credential
  data, status_code, headers = api_instance.create_credential_with_http_info(person_id, credential_input)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <Credential>
rescue DoorFlow::ApiError => e
  puts "Error when calling CredentialsApi->create_credential_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **person_id** | **Integer** | Person ID |  |
| **credential_input** | [**CredentialInput**](CredentialInput.md) |  |  |

### Return type

[**Credential**](Credential.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json


## delete_credential

> String delete_credential(person_id, id)

Delete credential

Deletes a credential. For HID Mobile Access credentials, this deactivates the mobile credential.

### Examples

```ruby
require 'time'
require 'doorflow-api'
# setup authorization
DoorFlow.configure do |config|
  # Configure OAuth2 access token for authorization: OAuth2
  config.access_token = 'YOUR ACCESS TOKEN'
end

api_instance = DoorFlow::CredentialsApi.new
person_id = 56 # Integer | Person ID
id = 'id_example' # String | Credential ID (hashid) or HID invitation ID (format 99xxxxxxxx)

begin
  # Delete credential
  result = api_instance.delete_credential(person_id, id)
  p result
rescue DoorFlow::ApiError => e
  puts "Error when calling CredentialsApi->delete_credential: #{e}"
end
```

#### Using the delete_credential_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(String, Integer, Hash)> delete_credential_with_http_info(person_id, id)

```ruby
begin
  # Delete credential
  data, status_code, headers = api_instance.delete_credential_with_http_info(person_id, id)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => String
rescue DoorFlow::ApiError => e
  puts "Error when calling CredentialsApi->delete_credential_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **person_id** | **Integer** | Person ID |  |
| **id** | **String** | Credential ID (hashid) or HID invitation ID (format 99xxxxxxxx) |  |

### Return type

**String**

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: text/plain, application/json


## get_credential

> <Credential> get_credential(person_id, id, opts)

Get credential details

Returns details for a specific credential

### Examples

```ruby
require 'time'
require 'doorflow-api'
# setup authorization
DoorFlow.configure do |config|
  # Configure OAuth2 access token for authorization: OAuth2
  config.access_token = 'YOUR ACCESS TOKEN'
end

api_instance = DoorFlow::CredentialsApi.new
person_id = 56 # Integer | Person ID
id = 'id_example' # String | Credential ID (hashid) or HID invitation ID (format 99xxxxxxxx)
opts = {
  callback: 'callback_example', # String | Webhook callback ID for acknowledgment
  ack_token: 'ack_token_example' # String | Webhook acknowledgment token
}

begin
  # Get credential details
  result = api_instance.get_credential(person_id, id, opts)
  p result
rescue DoorFlow::ApiError => e
  puts "Error when calling CredentialsApi->get_credential: #{e}"
end
```

#### Using the get_credential_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<Credential>, Integer, Hash)> get_credential_with_http_info(person_id, id, opts)

```ruby
begin
  # Get credential details
  data, status_code, headers = api_instance.get_credential_with_http_info(person_id, id, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <Credential>
rescue DoorFlow::ApiError => e
  puts "Error when calling CredentialsApi->get_credential_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **person_id** | **Integer** | Person ID |  |
| **id** | **String** | Credential ID (hashid) or HID invitation ID (format 99xxxxxxxx) |  |
| **callback** | **String** | Webhook callback ID for acknowledgment | [optional] |
| **ack_token** | **String** | Webhook acknowledgment token | [optional] |

### Return type

[**Credential**](Credential.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## list_all_credentials

> <Array<Credential>> list_all_credentials(opts)

List all credentials

Returns a paginated list of all credentials accessible to the authenticated user

### Examples

```ruby
require 'time'
require 'doorflow-api'
# setup authorization
DoorFlow.configure do |config|
  # Configure OAuth2 access token for authorization: OAuth2
  config.access_token = 'YOUR ACCESS TOKEN'
end

api_instance = DoorFlow::CredentialsApi.new
opts = {
  per_page: 56, # Integer | Number of results per page
  page: 56, # Integer | Page number for pagination
  skip_pagination: true # Boolean | Skip pagination and return all results
}

begin
  # List all credentials
  result = api_instance.list_all_credentials(opts)
  p result
rescue DoorFlow::ApiError => e
  puts "Error when calling CredentialsApi->list_all_credentials: #{e}"
end
```

#### Using the list_all_credentials_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<Array<Credential>>, Integer, Hash)> list_all_credentials_with_http_info(opts)

```ruby
begin
  # List all credentials
  data, status_code, headers = api_instance.list_all_credentials_with_http_info(opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <Array<Credential>>
rescue DoorFlow::ApiError => e
  puts "Error when calling CredentialsApi->list_all_credentials_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **per_page** | **Integer** | Number of results per page | [optional][default to 500] |
| **page** | **Integer** | Page number for pagination | [optional][default to 1] |
| **skip_pagination** | **Boolean** | Skip pagination and return all results | [optional] |

### Return type

[**Array&lt;Credential&gt;**](Credential.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## list_person_credentials

> <Array<Credential>> list_person_credentials(person_id, opts)

List person credentials

Returns a paginated list of credentials for a specific person, or all credentials if no person_id is provided

### Examples

```ruby
require 'time'
require 'doorflow-api'
# setup authorization
DoorFlow.configure do |config|
  # Configure OAuth2 access token for authorization: OAuth2
  config.access_token = 'YOUR ACCESS TOKEN'
end

api_instance = DoorFlow::CredentialsApi.new
person_id = 56 # Integer | Person ID
opts = {
  per_page: 56, # Integer | Number of results per page
  page: 56, # Integer | Page number for pagination
  skip_pagination: true # Boolean | Skip pagination and return all results
}

begin
  # List person credentials
  result = api_instance.list_person_credentials(person_id, opts)
  p result
rescue DoorFlow::ApiError => e
  puts "Error when calling CredentialsApi->list_person_credentials: #{e}"
end
```

#### Using the list_person_credentials_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<Array<Credential>>, Integer, Hash)> list_person_credentials_with_http_info(person_id, opts)

```ruby
begin
  # List person credentials
  data, status_code, headers = api_instance.list_person_credentials_with_http_info(person_id, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <Array<Credential>>
rescue DoorFlow::ApiError => e
  puts "Error when calling CredentialsApi->list_person_credentials_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **person_id** | **Integer** | Person ID |  |
| **per_page** | **Integer** | Number of results per page | [optional][default to 500] |
| **page** | **Integer** | Page number for pagination | [optional][default to 1] |
| **skip_pagination** | **Boolean** | Skip pagination and return all results | [optional] |

### Return type

[**Array&lt;Credential&gt;**](Credential.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## update_credential

> <Credential> update_credential(person_id, id, credential_update_input)

Update credential

Updates the value of an existing credential

### Examples

```ruby
require 'time'
require 'doorflow-api'
# setup authorization
DoorFlow.configure do |config|
  # Configure OAuth2 access token for authorization: OAuth2
  config.access_token = 'YOUR ACCESS TOKEN'
end

api_instance = DoorFlow::CredentialsApi.new
person_id = 56 # Integer | Person ID
id = 'id_example' # String | Credential ID (hashid)
credential_update_input = DoorFlow::CredentialUpdateInput.new({person_credential: DoorFlow::CredentialUpdateInputPersonCredential.new({value: '9876543210'})}) # CredentialUpdateInput | 

begin
  # Update credential
  result = api_instance.update_credential(person_id, id, credential_update_input)
  p result
rescue DoorFlow::ApiError => e
  puts "Error when calling CredentialsApi->update_credential: #{e}"
end
```

#### Using the update_credential_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<Credential>, Integer, Hash)> update_credential_with_http_info(person_id, id, credential_update_input)

```ruby
begin
  # Update credential
  data, status_code, headers = api_instance.update_credential_with_http_info(person_id, id, credential_update_input)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <Credential>
rescue DoorFlow::ApiError => e
  puts "Error when calling CredentialsApi->update_credential_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **person_id** | **Integer** | Person ID |  |
| **id** | **String** | Credential ID (hashid) |  |
| **credential_update_input** | [**CredentialUpdateInput**](CredentialUpdateInput.md) |  |  |

### Return type

[**Credential**](Credential.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json

