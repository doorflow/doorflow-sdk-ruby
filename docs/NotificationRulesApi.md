# DoorFlow::NotificationRulesApi

All URIs are relative to *https://api.doorflow.com*

| Method | HTTP request | Description |
| ------ | ------------ | ----------- |
| [**create_notification_rule**](NotificationRulesApi.md#create_notification_rule) | **POST** /api/3/notification_rules | Create notification rule |
| [**delete_notification_rule**](NotificationRulesApi.md#delete_notification_rule) | **DELETE** /api/3/notification_rules/{id} | Delete notification rule |
| [**get_notification_rule**](NotificationRulesApi.md#get_notification_rule) | **GET** /api/3/notification_rules/{id} | Get notification rule details |
| [**list_notification_rules**](NotificationRulesApi.md#list_notification_rules) | **GET** /api/3/notification_rules | List notification rules |
| [**update_notification_rule**](NotificationRulesApi.md#update_notification_rule) | **PUT** /api/3/notification_rules/{id} | Update notification rule |


## create_notification_rule

> <NotificationRule> create_notification_rule(notification_rule_input)

Create notification rule

Creates a new notification rule to trigger webhooks or other actions when specific events occur. At least one action and one event must be specified. 

### Examples

```ruby
require 'time'
require 'doorflow-api'
# setup authorization
DoorFlow.configure do |config|
  # Configure OAuth2 access token for authorization: OAuth2
  config.access_token = 'YOUR ACCESS TOKEN'
end

api_instance = DoorFlow::NotificationRulesApi.new
notification_rule_input = DoorFlow::NotificationRuleInput.new({name: 'Webhook for door access events', call_back_url: 'https://example.com/webhook', match_event_codes: [10, 11, 20]}) # NotificationRuleInput | 

begin
  # Create notification rule
  result = api_instance.create_notification_rule(notification_rule_input)
  p result
rescue DoorFlow::ApiError => e
  puts "Error when calling NotificationRulesApi->create_notification_rule: #{e}"
end
```

#### Using the create_notification_rule_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<NotificationRule>, Integer, Hash)> create_notification_rule_with_http_info(notification_rule_input)

```ruby
begin
  # Create notification rule
  data, status_code, headers = api_instance.create_notification_rule_with_http_info(notification_rule_input)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <NotificationRule>
rescue DoorFlow::ApiError => e
  puts "Error when calling NotificationRulesApi->create_notification_rule_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **notification_rule_input** | [**NotificationRuleInput**](NotificationRuleInput.md) |  |  |

### Return type

[**NotificationRule**](NotificationRule.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json


## delete_notification_rule

> <DeleteGroupReservation200Response> delete_notification_rule(id)

Delete notification rule

Deletes a notification rule

### Examples

```ruby
require 'time'
require 'doorflow-api'
# setup authorization
DoorFlow.configure do |config|
  # Configure OAuth2 access token for authorization: OAuth2
  config.access_token = 'YOUR ACCESS TOKEN'
end

api_instance = DoorFlow::NotificationRulesApi.new
id = 56 # Integer | Notification rule ID

begin
  # Delete notification rule
  result = api_instance.delete_notification_rule(id)
  p result
rescue DoorFlow::ApiError => e
  puts "Error when calling NotificationRulesApi->delete_notification_rule: #{e}"
end
```

#### Using the delete_notification_rule_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<DeleteGroupReservation200Response>, Integer, Hash)> delete_notification_rule_with_http_info(id)

```ruby
begin
  # Delete notification rule
  data, status_code, headers = api_instance.delete_notification_rule_with_http_info(id)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <DeleteGroupReservation200Response>
rescue DoorFlow::ApiError => e
  puts "Error when calling NotificationRulesApi->delete_notification_rule_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **id** | **Integer** | Notification rule ID |  |

### Return type

[**DeleteGroupReservation200Response**](DeleteGroupReservation200Response.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## get_notification_rule

> <NotificationRule> get_notification_rule(id)

Get notification rule details

Returns details for a specific notification rule

### Examples

```ruby
require 'time'
require 'doorflow-api'
# setup authorization
DoorFlow.configure do |config|
  # Configure OAuth2 access token for authorization: OAuth2
  config.access_token = 'YOUR ACCESS TOKEN'
end

api_instance = DoorFlow::NotificationRulesApi.new
id = 56 # Integer | Notification rule ID

begin
  # Get notification rule details
  result = api_instance.get_notification_rule(id)
  p result
rescue DoorFlow::ApiError => e
  puts "Error when calling NotificationRulesApi->get_notification_rule: #{e}"
end
```

#### Using the get_notification_rule_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<NotificationRule>, Integer, Hash)> get_notification_rule_with_http_info(id)

```ruby
begin
  # Get notification rule details
  data, status_code, headers = api_instance.get_notification_rule_with_http_info(id)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <NotificationRule>
rescue DoorFlow::ApiError => e
  puts "Error when calling NotificationRulesApi->get_notification_rule_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **id** | **Integer** | Notification rule ID |  |

### Return type

[**NotificationRule**](NotificationRule.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## list_notification_rules

> <Array<NotificationRule>> list_notification_rules

List notification rules

Returns a list of all notification rules for the authenticated user. Notification rules define webhooks or other actions that are triggered when specific events occur. This endpoint does not support pagination. 

### Examples

```ruby
require 'time'
require 'doorflow-api'
# setup authorization
DoorFlow.configure do |config|
  # Configure OAuth2 access token for authorization: OAuth2
  config.access_token = 'YOUR ACCESS TOKEN'
end

api_instance = DoorFlow::NotificationRulesApi.new

begin
  # List notification rules
  result = api_instance.list_notification_rules
  p result
rescue DoorFlow::ApiError => e
  puts "Error when calling NotificationRulesApi->list_notification_rules: #{e}"
end
```

#### Using the list_notification_rules_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<Array<NotificationRule>>, Integer, Hash)> list_notification_rules_with_http_info

```ruby
begin
  # List notification rules
  data, status_code, headers = api_instance.list_notification_rules_with_http_info
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <Array<NotificationRule>>
rescue DoorFlow::ApiError => e
  puts "Error when calling NotificationRulesApi->list_notification_rules_with_http_info: #{e}"
end
```

### Parameters

This endpoint does not need any parameter.

### Return type

[**Array&lt;NotificationRule&gt;**](NotificationRule.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

- **Content-Type**: Not defined
- **Accept**: application/json


## update_notification_rule

> <NotificationRule> update_notification_rule(id, notification_rule_input)

Update notification rule

Updates an existing notification rule. This replaces all conditions, events, and actions with the new values provided in the request. 

### Examples

```ruby
require 'time'
require 'doorflow-api'
# setup authorization
DoorFlow.configure do |config|
  # Configure OAuth2 access token for authorization: OAuth2
  config.access_token = 'YOUR ACCESS TOKEN'
end

api_instance = DoorFlow::NotificationRulesApi.new
id = 56 # Integer | Notification rule ID
notification_rule_input = DoorFlow::NotificationRuleInput.new({name: 'Webhook for door access events', call_back_url: 'https://example.com/webhook', match_event_codes: [10, 11, 20]}) # NotificationRuleInput | 

begin
  # Update notification rule
  result = api_instance.update_notification_rule(id, notification_rule_input)
  p result
rescue DoorFlow::ApiError => e
  puts "Error when calling NotificationRulesApi->update_notification_rule: #{e}"
end
```

#### Using the update_notification_rule_with_http_info variant

This returns an Array which contains the response data, status code and headers.

> <Array(<NotificationRule>, Integer, Hash)> update_notification_rule_with_http_info(id, notification_rule_input)

```ruby
begin
  # Update notification rule
  data, status_code, headers = api_instance.update_notification_rule_with_http_info(id, notification_rule_input)
  p status_code # => 2xx
  p headers # => { ... }
  p data # => <NotificationRule>
rescue DoorFlow::ApiError => e
  puts "Error when calling NotificationRulesApi->update_notification_rule_with_http_info: #{e}"
end
```

### Parameters

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **id** | **Integer** | Notification rule ID |  |
| **notification_rule_input** | [**NotificationRuleInput**](NotificationRuleInput.md) |  |  |

### Return type

[**NotificationRule**](NotificationRule.md)

### Authorization

[OAuth2](../README.md#OAuth2)

### HTTP request headers

- **Content-Type**: application/json
- **Accept**: application/json

