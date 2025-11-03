# DoorFlow::NotificationRule

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **id** | **Integer** | Unique identifier for the notification rule |  |
| **name** | **String** | Name of the notification rule |  |
| **active** | **Boolean** | Whether this notification rule is currently active |  |
| **conditions** | [**Array&lt;NotificationRuleConditionsInner&gt;**](NotificationRuleConditionsInner.md) | Conditions that must be met for the rule to trigger |  |
| **events** | [**Array&lt;NotificationRuleEventsInner&gt;**](NotificationRuleEventsInner.md) | Events that trigger this rule (at least one required) |  |
| **actions** | [**Array&lt;NotificationRuleActionsInner&gt;**](NotificationRuleActionsInner.md) | Actions to perform when the rule triggers (at least one required) |  |

## Example

```ruby
require 'doorflow-api'

instance = DoorFlow::NotificationRule.new(
  id: 100,
  name: Webhook for door access events,
  active: true,
  conditions: null,
  events: null,
  actions: null
)
```

