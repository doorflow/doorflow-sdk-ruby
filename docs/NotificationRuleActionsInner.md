# DoorFlow::NotificationRuleActionsInner

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **type** | **Integer** | Type of action (0 &#x3D; webhook callback) | [optional] |
| **type_description** | **String** | Human-readable description of the action type | [optional] |
| **data** | **String** | Action data (e.g., webhook URL) | [optional] |

## Example

```ruby
require 'doorflow-api'

instance = DoorFlow::NotificationRuleActionsInner.new(
  type: 0,
  type_description: Callback URL,
  data: https://example.com/webhook
)
```

