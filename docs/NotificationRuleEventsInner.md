# DoorFlow::NotificationRuleEventsInner

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **code** | **Integer** | Event code that triggers this rule | [optional] |
| **name** | **String** | Human-readable name of the event | [optional] |

## Example

```ruby
require 'doorflow-api'

instance = DoorFlow::NotificationRuleEventsInner.new(
  code: 10,
  name: Admit Card
)
```

