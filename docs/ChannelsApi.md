# DoorFlow::ChannelsApi

All URIs are relative to *https://api.doorflow.com*

| Method | HTTP request | Description |
| ------ | ------------ | ----------- |
| [**admit_channel**](ChannelsApi.md#admit_channel) | **POST** /api/3/channels/{id}/admit | Admit through channel (any person) |
| [**admit_person**](ChannelsApi.md#admit_person) | **POST** /api/3/channels/{id}/admit_person | Admit specific person through channel |
| [**auto_unlock_channel**](ChannelsApi.md#auto_unlock_channel) | **POST** /api/3/channels/{id}/auto_unlock | Set auto-unlock shift |
| [**get_channel**](ChannelsApi.md#get_channel) | **GET** /api/3/channels/{id} | Get channel details |
| [**list_channels**](ChannelsApi.md#list_channels) | **GET** /api/3/channels | List channels (door controllers) |
| [**lockdown_channel**](ChannelsApi.md#lockdown_channel) | **POST** /api/3/channels/{id}/lockdown | Enable lockdown mode |
| [**normal_channel**](ChannelsApi.md#normal_channel) | **POST** /api/3/channels/{id}/normal | Return channel to normal mode |
| [**regenerate_encryption_key**](ChannelsApi.md#regenerate_encryption_key) | **POST** /api/3/channels/{id}/regenerate_encryption_key | Regenerate encryption key |
| [**remove_encryption_key**](ChannelsApi.md#remove_encryption_key) | **POST** /api/3/channels/{id}/remove_encryption_key | Remove encryption key |
| [**unlock_channel**](ChannelsApi.md#unlock_channel) | **POST** /api/3/channels/{id}/unlock | Unlock channel (unlock mode) |
| [**unlockdown_channel**](ChannelsApi.md#unlockdown_channel) | **POST** /api/3/channels/{id}/unlockdown | Disable lockdown mode |


## admit_channel

> <AdmitChannel202Response> admit_channel(id)

Admit through channel (any person)

Requests immediate admission through a channel without specifying a person. This creates an admission request that momentarily unlocks the door. Returns an admission_request_id that can be used to track the status via GET /api/3/admission_requests/:id. Only works when the channel is in normal mode (not in unlock mode). 

### Examples

```ruby
require 'time'
require 'doorflow-api'
# setup authorization
DoorFlow.configure do |config|
  # Configure OAuth2 access token for authorization: OAuth2
  config.access_token = 'YOUR ACCESS TOKEN'
end

api_instance = DoorFlow::ChannelsApi.new
id = 56 # Integer | Channel ID

begin
  # Admit through channel (any person)
  result = api_instance.admit_channel(id)
  p result
rescue DoorFlow::ApiError => e
  puts "Error when calling ChannelsApi->admit_channel: #{e}"
end
```

#### Using the admit_channel_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<AdmitChannel202Response>, Integer, Hash)> admit_channel_with_http_info(id)

```ruby
begin
  # Admit through channel (any person)
  data, status_code, headers = api_instance.admit_channel_with_http_info(id)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <AdmitChannel202Response>
rescue DoorFlow::ApiError => e
  puts "Error when calling ChannelsApi->admit_channel_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **id** | **Integer** | Channel ID |  |

### Return type

[**AdmitChannel202Response**](AdmitChannel202Response.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## admit_person

> <AdmitPerson202Response> admit_person(id, admit_person_request)

Admit specific person through channel

Requests admission for a specific person through a channel. This checks if the person has valid credentials and access rights before admitting. Returns an admission_request_id for tracking via GET /api/3/admission_requests/:id. 

### Examples

```ruby
require 'time'
require 'doorflow-api'
# setup authorization
DoorFlow.configure do |config|
  # Configure OAuth2 access token for authorization: OAuth2
  config.access_token = 'YOUR ACCESS TOKEN'
end

api_instance = DoorFlow::ChannelsApi.new
id = 56 # Integer | Channel ID
admit_person_request = DoorFlow::AdmitPersonRequest.new({person_id: 12345}) # AdmitPersonRequest | 

begin
  # Admit specific person through channel
  result = api_instance.admit_person(id, admit_person_request)
  p result
rescue DoorFlow::ApiError => e
  puts "Error when calling ChannelsApi->admit_person: #{e}"
end
```

#### Using the admit_person_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<AdmitPerson202Response>, Integer, Hash)> admit_person_with_http_info(id, admit_person_request)

```ruby
begin
  # Admit specific person through channel
  data, status_code, headers = api_instance.admit_person_with_http_info(id, admit_person_request)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <AdmitPerson202Response>
rescue DoorFlow::ApiError => e
  puts "Error when calling ChannelsApi->admit_person_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **id** | **Integer** | Channel ID |  |
| **admit_person_request** | [**AdmitPersonRequest**](AdmitPersonRequest.md) |  |  |

### Return type

[**AdmitPerson202Response**](AdmitPerson202Response.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json


## auto_unlock_channel

> <Channel> auto_unlock_channel(id, opts)

Set auto-unlock shift

Configures a shift during which the channel automatically unlocks. Provide a shift_id to enable auto-unlock, or omit it to disable. 

### Examples

```ruby
require 'time'
require 'doorflow-api'
# setup authorization
DoorFlow.configure do |config|
  # Configure OAuth2 access token for authorization: OAuth2
  config.access_token = 'YOUR ACCESS TOKEN'
end

api_instance = DoorFlow::ChannelsApi.new
id = 56 # Integer | Channel ID
opts = {
  auto_unlock_channel_request: DoorFlow::AutoUnlockChannelRequest.new # AutoUnlockChannelRequest | 
}

begin
  # Set auto-unlock shift
  result = api_instance.auto_unlock_channel(id, opts)
  p result
rescue DoorFlow::ApiError => e
  puts "Error when calling ChannelsApi->auto_unlock_channel: #{e}"
end
```

#### Using the auto_unlock_channel_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<Channel>, Integer, Hash)> auto_unlock_channel_with_http_info(id, opts)

```ruby
begin
  # Set auto-unlock shift
  data, status_code, headers = api_instance.auto_unlock_channel_with_http_info(id, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <Channel>
rescue DoorFlow::ApiError => e
  puts "Error when calling ChannelsApi->auto_unlock_channel_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **id** | **Integer** | Channel ID |  |
| **auto_unlock_channel_request** | [**AutoUnlockChannelRequest**](AutoUnlockChannelRequest.md) |  | [optional] |

### Return type

[**Channel**](Channel.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json


## get_channel

> <Channel> get_channel(id)

Get channel details

Returns details for a specific channel (door controller)

### Examples

```ruby
require 'time'
require 'doorflow-api'
# setup authorization
DoorFlow.configure do |config|
  # Configure OAuth2 access token for authorization: OAuth2
  config.access_token = 'YOUR ACCESS TOKEN'
end

api_instance = DoorFlow::ChannelsApi.new
id = 56 # Integer | Channel ID

begin
  # Get channel details
  result = api_instance.get_channel(id)
  p result
rescue DoorFlow::ApiError => e
  puts "Error when calling ChannelsApi->get_channel: #{e}"
end
```

#### Using the get_channel_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<Channel>, Integer, Hash)> get_channel_with_http_info(id)

```ruby
begin
  # Get channel details
  data, status_code, headers = api_instance.get_channel_with_http_info(id)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <Channel>
rescue DoorFlow::ApiError => e
  puts "Error when calling ChannelsApi->get_channel_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **id** | **Integer** | Channel ID |  |

### Return type

[**Channel**](Channel.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## list_channels

> <Array<Channel>> list_channels(opts)

List channels (door controllers)

Returns a paginated list of channels (door controllers) accessible to the authenticated user

### Examples

```ruby
require 'time'
require 'doorflow-api'
# setup authorization
DoorFlow.configure do |config|
  # Configure OAuth2 access token for authorization: OAuth2
  config.access_token = 'YOUR ACCESS TOKEN'
end

api_instance = DoorFlow::ChannelsApi.new
opts = {
  site_id: 56, # Integer | Filter channels by site ID
  per_page: 56, # Integer | Number of results per page
  page: 56, # Integer | Page number for pagination
  skip_pagination: true # Boolean | Skip pagination and return all results
}

begin
  # List channels (door controllers)
  result = api_instance.list_channels(opts)
  p result
rescue DoorFlow::ApiError => e
  puts "Error when calling ChannelsApi->list_channels: #{e}"
end
```

#### Using the list_channels_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<Array<Channel>>, Integer, Hash)> list_channels_with_http_info(opts)

```ruby
begin
  # List channels (door controllers)
  data, status_code, headers = api_instance.list_channels_with_http_info(opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <Array<Channel>>
rescue DoorFlow::ApiError => e
  puts "Error when calling ChannelsApi->list_channels_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **site_id** | **Integer** | Filter channels by site ID | [optional] |
| **per_page** | **Integer** | Number of results per page | [optional][default to 500] |
| **page** | **Integer** | Page number for pagination | [optional][default to 1] |
| **skip_pagination** | **Boolean** | Skip pagination and return all results | [optional] |

### Return type

[**Array&lt;Channel&gt;**](Channel.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## lockdown_channel

> <Channel> lockdown_channel(id, opts)

Enable lockdown mode

Puts a channel into lockdown mode, restricting various types of access. You can selectively lock down card access, REX (Request to Exit), and AUX inputs. 

### Examples

```ruby
require 'time'
require 'doorflow-api'
# setup authorization
DoorFlow.configure do |config|
  # Configure OAuth2 access token for authorization: OAuth2
  config.access_token = 'YOUR ACCESS TOKEN'
end

api_instance = DoorFlow::ChannelsApi.new
id = 56 # Integer | Channel ID
opts = {
  lockdown_channel_request: DoorFlow::LockdownChannelRequest.new # LockdownChannelRequest | 
}

begin
  # Enable lockdown mode
  result = api_instance.lockdown_channel(id, opts)
  p result
rescue DoorFlow::ApiError => e
  puts "Error when calling ChannelsApi->lockdown_channel: #{e}"
end
```

#### Using the lockdown_channel_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<Channel>, Integer, Hash)> lockdown_channel_with_http_info(id, opts)

```ruby
begin
  # Enable lockdown mode
  data, status_code, headers = api_instance.lockdown_channel_with_http_info(id, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <Channel>
rescue DoorFlow::ApiError => e
  puts "Error when calling ChannelsApi->lockdown_channel_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **id** | **Integer** | Channel ID |  |
| **lockdown_channel_request** | [**LockdownChannelRequest**](LockdownChannelRequest.md) |  | [optional] |

### Return type

[**Channel**](Channel.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json


## normal_channel

> <Channel> normal_channel(id)

Return channel to normal mode

Cancels unlock mode and returns the channel to normal access control mode

### Examples

```ruby
require 'time'
require 'doorflow-api'
# setup authorization
DoorFlow.configure do |config|
  # Configure OAuth2 access token for authorization: OAuth2
  config.access_token = 'YOUR ACCESS TOKEN'
end

api_instance = DoorFlow::ChannelsApi.new
id = 56 # Integer | Channel ID

begin
  # Return channel to normal mode
  result = api_instance.normal_channel(id)
  p result
rescue DoorFlow::ApiError => e
  puts "Error when calling ChannelsApi->normal_channel: #{e}"
end
```

#### Using the normal_channel_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<Channel>, Integer, Hash)> normal_channel_with_http_info(id)

```ruby
begin
  # Return channel to normal mode
  data, status_code, headers = api_instance.normal_channel_with_http_info(id)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <Channel>
rescue DoorFlow::ApiError => e
  puts "Error when calling ChannelsApi->normal_channel_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **id** | **Integer** | Channel ID |  |

### Return type

[**Channel**](Channel.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## regenerate_encryption_key

> <Channel> regenerate_encryption_key(id)

Regenerate encryption key

Generates a new encryption key for secure communication with the channel

### Examples

```ruby
require 'time'
require 'doorflow-api'
# setup authorization
DoorFlow.configure do |config|
  # Configure OAuth2 access token for authorization: OAuth2
  config.access_token = 'YOUR ACCESS TOKEN'
end

api_instance = DoorFlow::ChannelsApi.new
id = 56 # Integer | Channel ID

begin
  # Regenerate encryption key
  result = api_instance.regenerate_encryption_key(id)
  p result
rescue DoorFlow::ApiError => e
  puts "Error when calling ChannelsApi->regenerate_encryption_key: #{e}"
end
```

#### Using the regenerate_encryption_key_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<Channel>, Integer, Hash)> regenerate_encryption_key_with_http_info(id)

```ruby
begin
  # Regenerate encryption key
  data, status_code, headers = api_instance.regenerate_encryption_key_with_http_info(id)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <Channel>
rescue DoorFlow::ApiError => e
  puts "Error when calling ChannelsApi->regenerate_encryption_key_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **id** | **Integer** | Channel ID |  |

### Return type

[**Channel**](Channel.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## remove_encryption_key

> <Channel> remove_encryption_key(id)

Remove encryption key

Removes the encryption key, disabling encrypted communication with the channel

### Examples

```ruby
require 'time'
require 'doorflow-api'
# setup authorization
DoorFlow.configure do |config|
  # Configure OAuth2 access token for authorization: OAuth2
  config.access_token = 'YOUR ACCESS TOKEN'
end

api_instance = DoorFlow::ChannelsApi.new
id = 56 # Integer | Channel ID

begin
  # Remove encryption key
  result = api_instance.remove_encryption_key(id)
  p result
rescue DoorFlow::ApiError => e
  puts "Error when calling ChannelsApi->remove_encryption_key: #{e}"
end
```

#### Using the remove_encryption_key_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<Channel>, Integer, Hash)> remove_encryption_key_with_http_info(id)

```ruby
begin
  # Remove encryption key
  data, status_code, headers = api_instance.remove_encryption_key_with_http_info(id)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <Channel>
rescue DoorFlow::ApiError => e
  puts "Error when calling ChannelsApi->remove_encryption_key_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **id** | **Integer** | Channel ID |  |

### Return type

[**Channel**](Channel.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## unlock_channel

> <Channel> unlock_channel(id, opts)

Unlock channel (unlock mode)

Puts a channel into unlock mode, where the door remains unlocked until a specified time. If no relock_at time is provided, the door remains unlocked until normal mode is restored. 

### Examples

```ruby
require 'time'
require 'doorflow-api'
# setup authorization
DoorFlow.configure do |config|
  # Configure OAuth2 access token for authorization: OAuth2
  config.access_token = 'YOUR ACCESS TOKEN'
end

api_instance = DoorFlow::ChannelsApi.new
id = 56 # Integer | Channel ID
opts = {
  unlock_channel_request: DoorFlow::UnlockChannelRequest.new # UnlockChannelRequest | 
}

begin
  # Unlock channel (unlock mode)
  result = api_instance.unlock_channel(id, opts)
  p result
rescue DoorFlow::ApiError => e
  puts "Error when calling ChannelsApi->unlock_channel: #{e}"
end
```

#### Using the unlock_channel_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<Channel>, Integer, Hash)> unlock_channel_with_http_info(id, opts)

```ruby
begin
  # Unlock channel (unlock mode)
  data, status_code, headers = api_instance.unlock_channel_with_http_info(id, opts)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <Channel>
rescue DoorFlow::ApiError => e
  puts "Error when calling ChannelsApi->unlock_channel_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **id** | **Integer** | Channel ID |  |
| **unlock_channel_request** | [**UnlockChannelRequest**](UnlockChannelRequest.md) |  | [optional] |

### Return type

[**Channel**](Channel.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json


## unlockdown_channel

> <Channel> unlockdown_channel(id)

Disable lockdown mode

Removes lockdown mode from a channel, restoring normal access control

### Examples

```ruby
require 'time'
require 'doorflow-api'
# setup authorization
DoorFlow.configure do |config|
  # Configure OAuth2 access token for authorization: OAuth2
  config.access_token = 'YOUR ACCESS TOKEN'
end

api_instance = DoorFlow::ChannelsApi.new
id = 56 # Integer | Channel ID

begin
  # Disable lockdown mode
  result = api_instance.unlockdown_channel(id)
  p result
rescue DoorFlow::ApiError => e
  puts "Error when calling ChannelsApi->unlockdown_channel: #{e}"
end
```

#### Using the unlockdown_channel_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<Channel>, Integer, Hash)> unlockdown_channel_with_http_info(id)

```ruby
begin
  # Disable lockdown mode
  data, status_code, headers = api_instance.unlockdown_channel_with_http_info(id)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <Channel>
rescue DoorFlow::ApiError => e
  puts "Error when calling ChannelsApi->unlockdown_channel_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **id** | **Integer** | Channel ID |  |

### Return type

[**Channel**](Channel.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json

