# DoorFlow::NotificationRuleInput

## Properties

| Name | Type | Description | Notes |
| ---- | ---- | ----------- | ----- |
| **name** | **String** | Name of the notification rule (required) |  |
| **active** | **Boolean** | Whether this notification rule is active | [optional][default to true] |
| **call_back_url** | **String** | Webhook callback URL to trigger when events occur (required) |  |
| **match_event_codes** | **Array&lt;Integer&gt;** | Array of event codes that trigger this rule (at least one required) |  |
| **match_controller_ids** | **Array&lt;Integer&gt;** | Array of door controller IDs to filter events (optional - if omitted, matches all controllers) | [optional] |

## Example

```ruby
require 'doorflow-api'

instance = DoorFlow::NotificationRuleInput.new(
  name: Webhook for door access events,
  active: true,
  call_back_url: https://example.com/webhook,
  match_event_codes: [10,11,20],
  match_controller_ids: [1340,1341]
)
```

