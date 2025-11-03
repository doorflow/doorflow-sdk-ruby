# DoorFlow::NotificationRuleConditionsInner

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **type** | **String** | Type of condition (e.g., \&quot;door_controller_id\&quot;) | [optional] |
| **type_description** | **String** | Human-readable description of the condition type | [optional] |
| **value** | **String** | Value to match against | [optional] |

## Example

```ruby
require 'doorflow-api'

instance = DoorFlow::NotificationRuleConditionsInner.new(
  type: door_controller_id,
  type_description: Door Controller,
  value: 1340
)
```

